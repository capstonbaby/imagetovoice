from flask import Flask, jsonify, request
import clarifaiAPI
import cloudsight
import httplib, urllib, base64, json

MS_VISION_KEY = '6c8fa85edf7c47488eae0f1a6827b72c'

app = Flask(__name__)

auth = cloudsight.SimpleAuth('kZH5jI5q2CSUD5Ofrsd8Dg')
api = cloudsight.API(auth)

###########################
# Cloudsight
###########################
@app.route('/cloudsight/v1.0/image',methods=['GET'])
def index():
	url = request.args.get('url')
	response = api.remote_image_request(url, {
     'image_request[locale]': 'en-US',
	})
	status = api.wait(response['token'], timeout=30)
	return jsonify(status)

###########################
# Clarifai
###########################
@app.route('/clarifai/v1.0/image', methods=['GET'])
def get_content():
	url = request.args.get('url')
	return clarifaiAPI.get_tags(url)

@app.route('/clarifai/v1.0/getconcepts', methods=['GET'])
def get_concepts():
	response = json.dumps(clarifaiAPI.get_concepts())
	return response

@app.route('/clarifai/v1.0/deleteconcepts', methods=['GET'])
def delete_concepts():
	name = request.args.get('name')
	response = json.dumps(clarifaiAPI.delete_concepts(name))
	return response

@app.route('/clarifai/v1.0/createconcept', methods=['GET'])
def create_concept():
	idConcept = request.args.get('id')
	response = clarifaiAPI.create_concept(idConcept)
	return response

@app.route('/clarifai/v1.0/getconcept', methods=['GET'])
def get_concept():
	idConcept = request.args.get('id')
	response = clarifaiAPI.get_concept(idConcept)
	return response

@app.route('/clarifai/v1.0/createimage', methods=['GET'])
def create_image():
	urlImage = request.args.get('url')
	concept = request.args.get('conceptid')
	c = []
	c.append(concept)
	response = clarifaiAPI.create_image(urlImage, c)
	return response

@app.route('/clarifai/v1.0/trainmodel', methods=['GET'])
def train_model():
	return clarifaiAPI.train_model()
	
@app.route('/clarifai/v1.0/deleteimage', methods=['GET'])
def train_model():
	imageId = request.args.get('imageId')
	return clarifaiAPI.delete_image(imageId)	
###########################
# Microsoft
###########################
@app.route('/microsoft/v1.0/image', methods=['GET'])
def describe_image():
	url = request.args.get('url')
	headers = {
    # Request headers
    'Content-Type': 'application/json',
    'Ocp-Apim-Subscription-Key': MS_VISION_KEY,
	}

	params = urllib.urlencode({
	    # Request parameters
	    'maxCandidates': '1',
	})

	body = "{'Url':'" + url + "'}"

	
	conn = httplib.HTTPSConnection('westus.api.cognitive.microsoft.com')
	conn.request("POST", "/vision/v1.0/describe?%s" % params, body, headers)
	response = conn.getresponse()
	data = response.read()
	conn.close()
		

	return data

@app.route('/')
def hello_world():
	return "Have a nice day"
if __name__ == '__main__':
    app.run(debug=True)