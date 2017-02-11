package com.example.mypc.aaiv_voicecontrol.services;

import android.text.TextUtils;
import android.util.Log;
import android.widget.Toast;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.example.mypc.aaiv_voicecontrol.AddPersonActivity;
import com.example.mypc.aaiv_voicecontrol.CameraActivity_2;
import com.example.mypc.aaiv_voicecontrol.Helper.NotificationHelper;
import com.example.mypc.aaiv_voicecontrol.Utils.NetworkUtil;
import com.example.mypc.aaiv_voicecontrol.imgur_model.ImageResponse;
import com.example.mypc.aaiv_voicecontrol.imgur_model.Upload;
import com.example.mypc.aaiv_voicecontrol.person_model.AddPersonFaceResponse;
import com.example.mypc.aaiv_voicecontrol.person_model.AddPersonResponse;
import com.example.mypc.aaiv_voicecontrol.person_model.Candidate;
import com.example.mypc.aaiv_voicecontrol.person_model.FaceDetectResponse;
import com.example.mypc.aaiv_voicecontrol.person_model.FaceIdentifyResponse;
import com.example.mypc.aaiv_voicecontrol.person_model.Person;
import com.example.mypc.aaiv_voicecontrol.vision_model.VisionResponse;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import id.zelory.compressor.Compressor;
import okhttp3.MediaType;
import okhttp3.MultipartBody;
import okhttp3.RequestBody;
import retrofit2.Response;

/**
 * Created by MyPC on 02/06/2017.
 */

public class MainServices {
    private String uploadResponse;
    private String identifyResponse = "Identify Fail";
    private Upload upload;
    private File takenPicture;
    private String faceIds = "";

    Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
            "cloud_name", "debwqzo2g",
            "api_key", "852288139213848",
            "api_secret", "qsuCuMnpTZ11_WxuIuQ5kPZmdr4"));


    public NotificationHelper notificationHelper = new NotificationHelper(CameraActivity_2.getContext());

    public String UploadByCloudinary(File imageFile){

        File compressedImage = Compressor.getDefault(CameraActivity_2.getContext()).compressToFile(imageFile);

        try {
            Map uploadResult = cloudinary.uploader().upload(compressedImage, ObjectUtils.emptyMap());
            final String url = (String) uploadResult.get("url");

            Log.d("link", url);
            return url;
        } catch (IOException e) {
            e.printStackTrace();
        }

        return "";
    }

    public String uploadImage(String filePath) {

        if (filePath != null) {
            notificationHelper.createUploadingNotification();

            takenPicture = new File(filePath);
            createUpload(takenPicture);

            if (NetworkUtil.isConnected(CameraActivity_2.getContext())) {
                MultipartBody.Part body = MultipartBody.Part.createFormData(
                        "image",
                        upload.image.getName(),
                        RequestBody.create(MediaType.parse("image/*"), upload.image)
                );

                try {
                    // Upload Synchronously
                    ImageResponse response = new UploadService().Execute(body, upload).execute().body();
                    uploadResponse = response.data.link;
                    Log.d("imageLink", uploadResponse);
                    notificationHelper.createUploadedNotification(response);
                } catch (IOException e) {
                    e.printStackTrace();
                }

                return uploadResponse;
            } else {
                notificationHelper.createFailedUploadNotification();
                Toast.makeText(CameraActivity_2.getContext(), "Cannot Connect To the Internet", Toast.LENGTH_LONG).show();
            }
        } else {
            Toast.makeText(CameraActivity_2.getContext(), "File Path Not Found", Toast.LENGTH_LONG).show();
        }

        return null;
    }

    private void createUpload(File image) {
        upload = new Upload();

        upload.image = image;
        upload.title = "testing";
    }

    public String IdentifyPerson(String urlImage) {

        final PersonServices service = new PersonServices();

        try {
            List<FaceDetectResponse> faceDetectResponses = service.DetectFaces(urlImage).execute().body();
            if (faceDetectResponses != null) {
                List<String> listFaceIds = new ArrayList<>();

                for (FaceDetectResponse faceDetected :
                        faceDetectResponses) {
                    Log.d("Detect", faceDetected.faceId);
                    listFaceIds.add(faceDetected.faceId);
                }

                faceIds = TextUtils.join(",", listFaceIds);

                List<FaceIdentifyResponse> faceIdentifyResponses = service.IdentifyPerson("friend", faceIds).execute().body();
                if (faceIdentifyResponses != null) {

                    for (FaceIdentifyResponse faceIdentified :
                            faceIdentifyResponses) {
                        Log.d("Identify", "Candidates for faceId: " + faceIdentified.faceId);
                        for (Candidate candidate :
                                faceIdentified.candidates) {
                            Log.d("Identify", candidate.personId);
                            Person person = service.GetPersonById("friend", candidate.personId).execute().body();
                            if (person != null) {
                                identifyResponse = person.name + ". " + person.userData;
                            } else {
                                Log.e("Person", "Can't get person");
                            }
                        }
                    }

                } else {
                    Toast.makeText(CameraActivity_2.getContext(), "Identify Person Failed", Toast.LENGTH_SHORT).show();
                }
            } else {
                Toast.makeText(CameraActivity_2.getContext(), "Detect Faces Failed", Toast.LENGTH_SHORT).show();
            }


        } catch (IOException e) {
            e.printStackTrace();
        }


//        service.DetectFaces(urlImage).enqueue(new Callback<List<FaceDetectResponse>>() {
//            @Override
//            public void onResponse(Call<List<FaceDetectResponse>> call, Response<List<FaceDetectResponse>> response) {
//
//
//                List<String> listFaceIds = new ArrayList<>();
//
//                for (FaceDetectResponse faceDetected :
//                        response.body()) {
//                    Log.d("Detect", faceDetected.faceId);
//                    listFaceIds.add(faceDetected.faceId);
//                }
//
//                faceIds = TextUtils.join(",", listFaceIds);
//
//                service.IdentifyPerson("111", faceIds).enqueue(new Callback<List<FaceIdentifyResponse>>() {
//                    @Override
//                    public void onResponse(Call<List<FaceIdentifyResponse>> call, Response<List<FaceIdentifyResponse>> response) {
//                        for (FaceIdentifyResponse faceIdentified :
//                                response.body()) {
//                            Log.d("Identify", "Candidates for faceId: " + faceIdentified.faceId);
//                            for (Candidate candidate :
//                                    faceIdentified.candidates) {
//                                Log.d("Identify", candidate.personId);
//                                service.GetPersonById("111", candidate.personId)
//                                        .enqueue(new Callback<Person>() {
//                                            @Override
//                                            public void onResponse(Call<Person> call, Response<Person> response) {
//                                                Log.d("Person", response.body().name);
//                                                Log.d("Person", response.body().userData);
//
//                                                identifyResponse = response.body().name + ". " + response.body().userData;
//
//                                                Toast.makeText(CameraActivity.getContext(),
//                                                        response.body().name + ". " + response.body().userData, Toast.LENGTH_LONG).show();
//                                            }
//
//                                            @Override
//                                            public void onFailure(Call<Person> call, Throwable t) {
//                                                Log.e("Person", "Can't get person");
//                                                Toast.makeText(CameraActivity.getContext(), "Can't get identified person", Toast.LENGTH_LONG).show();
//                                            }
//                                        });
//                            }
//                        }
//                    }
//
//                    @Override
//                    public void onFailure(Call<List<FaceIdentifyResponse>> call, Throwable t) {
//                        Toast.makeText(CameraActivity.getContext(), "Identify Person Failed", Toast.LENGTH_SHORT).show();
//                        t.printStackTrace();
//                    }
//                });
//            }
//
//            @Override
//            public void onFailure(Call<List<FaceDetectResponse>> call, Throwable t) {
//                Toast.makeText(CameraActivity.getContext(), "Detect Faces Failed", Toast.LENGTH_SHORT).show();
//                t.printStackTrace();
//            }
//        });
        return identifyResponse;
    }

    public void CreatePerson(String name, final String des, final String personGroupId, final String urlImage) {

        PersonServices personServices = new PersonServices();

        try {
            Toast.makeText(AddPersonActivity.getContext(), "Creating person..", Toast.LENGTH_LONG).show();

            Response<AddPersonResponse> addPersonResponseCall = personServices.CreatePerson(name, des, personGroupId).execute();
            if (addPersonResponseCall.isSuccessful()) {
                AddPersonResponse addPersonResponse = addPersonResponseCall.body();
                Toast.makeText(AddPersonActivity.getContext(), "Adding person..", Toast.LENGTH_LONG).show();

                Response<AddPersonFaceResponse> addPersonFaceResponseCall =
                        personServices.AddPersonFace(personGroupId, addPersonResponse.getPersonId(), urlImage, des).execute();
                if (addPersonFaceResponseCall.isSuccessful()) {
                    Toast.makeText(AddPersonActivity.getContext(), "Added person successfully, training group..", Toast.LENGTH_SHORT).show();
                    Response<Void> trainingResponse =  personServices.TrainPersonGroup(personGroupId).execute();
                    if(trainingResponse.isSuccessful()){
                        Toast.makeText(AddPersonActivity.getContext(), "Done !", Toast.LENGTH_SHORT).show();
                    } else {
                        Toast.makeText(AddPersonActivity.getContext(), "Training group failed", Toast.LENGTH_LONG).show();
                    }
                } else {
                    Toast.makeText(AddPersonActivity.getContext(), "Add person face failed", Toast.LENGTH_LONG).show();
                }
            } else {
                Toast.makeText(AddPersonActivity.getContext(), "Create Person Failed", Toast.LENGTH_LONG).show();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

//        new PersonServices().CreatePerson(name, des, personGroupId).enqueue(new Callback<AddPersonResponse>() {
//            @Override
//            public void onResponse(Call<AddPersonResponse> call, Response<AddPersonResponse> response) {
//                if (response.isSuccessful()) {
//                    Toast.makeText(AddPersonActivity.this, response.body().getPersonId(), Toast.LENGTH_LONG).show();
//
//                    new PersonServices().AddPersonFace(personGroupId, response.body().getPersonId(), urlImage, des)
//                            .enqueue(new Callback<AddPersonFaceResponse>() {
//                                @Override
//                                public void onResponse(Call<AddPersonFaceResponse> call, Response<AddPersonFaceResponse> response) {
//                                    if (response.isSuccessful()) {
//                                        Toast.makeText(AddPersonActivity.this, "Done !", Toast.LENGTH_SHORT).show();
//                                        new PersonServices().TrainPersonGroup(personGroupId);
//                                    }
//                                }
//
//                                @Override
//                                public void onFailure(Call<AddPersonFaceResponse> call, Throwable t) {
//                                    Toast.makeText(AddPersonActivity.this, "Add person face failed", Toast.LENGTH_LONG).show();
//                                }
//                            });
//
//                } else {
//                    Toast.makeText(AddPersonActivity.this, "Create Person Failed", Toast.LENGTH_LONG).show();
//                }
//            }
//
//            @Override
//            public void onFailure(Call<AddPersonResponse> call, Throwable t) {
//                Toast.makeText(AddPersonActivity.this, "Create Person Process Failed", Toast.LENGTH_LONG).show();
//                t.printStackTrace();
//            }
//        });
    }
    
    public VisionResponse DetectVision(String url){
        VisionResponse visionResponse = null;


        VisionService visionService = new VisionService();
        try {
            Response<VisionResponse> response = visionService.DetectVision(url).execute();
            if(response.isSuccessful()){
                visionResponse = response.body();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return visionResponse;
    }
}
