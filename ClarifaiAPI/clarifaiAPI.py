#trungthanhbp@gmail.com
#CLARIFAI_CLIENT_ID = 'O8CvHlKuxzc4zR8JAjtO90fVA4JQQfUz83IeHQ-_'
#CLARIFAI_CLIENT_SECRET = '5rzv0-uqK0wQ5TrKKOC94vMAkTZpF-T6PkS3g-Mg'
from clarifai.rest import Image as ClImage, ClarifaiApp
import json

CLARIFAI_CLIENT_ID = 'T3crM-R-OybH8iZKJJH-JY--WHLhnIZH6CiV0tnA' 
CLARIFAI_CLIENT_SECRET = 'BmJZCGkz-J9HdJZxpiMWT4--tD7wOMJ9t8eS675o'

appClarifai = ClarifaiApp(CLARIFAI_CLIENT_ID, CLARIFAI_CLIENT_SECRET)


def get_tags(url):
	modelClarifai = appClarifai.models.get('capstone')
	image = ClImage(url)
	data = modelClarifai.predict([image])
	response = json.dumps(data)
	return response

def get_concepts():
	modelClarifai = appClarifai.models.get('capstone')
	response = modelClarifai.get_concept_ids()
	return response

def delete_concepts(name):
	modelClarifai = appClarifai.models.get('capstone')
	response = modelClarifai.delete_concepts(name)
	return 'Ok'

def create_concept(idConcept):
	modelClarifai = appClarifai.models.get('capstone')
	c = []
	c.append(idConcept)
	modelClarifai.add_concepts(c)
	return 'True'

def get_concept(idConcept):
	modelClarifai = appClarifai.models.get('capstone')
	try:
		data = modelClarifai.concepts.get(idConcept)
	except Exception:
		return 'False'
	return 'True'

def create_image(urlImage, conceptid):
	modelClarifai = appClarifai.models.get('capstone')
	c = []
	c.append(conceptid)
	response = appClarifai.inputs.create_image_from_url(url=urlImage, concepts=c)
	train_model()
	return response.input_id

def train_model():
	modelClarifai = appClarifai.models.get('capstone')
	modelClarifai.train()
	return 'Ok'
	
def delete_image(imageId):
	modelClarifai = appClarifai.models.get('capstone')
	ret = appClarifai.inputs.delete(imageId)
	return 'Ok'