package com.example.mypc.aaiv_voicecontrol.services;

import android.text.TextUtils;
import android.util.Log;
import android.widget.Toast;

import com.example.mypc.aaiv_voicecontrol.CameraActivity_2;
import com.example.mypc.aaiv_voicecontrol.imgur_model.Upload;
import com.example.mypc.aaiv_voicecontrol.person_model.Candidate;
import com.example.mypc.aaiv_voicecontrol.person_model.FaceDetectResponse;
import com.example.mypc.aaiv_voicecontrol.person_model.FaceIdentifyResponse;
import com.example.mypc.aaiv_voicecontrol.person_model.Person;
import com.example.mypc.aaiv_voicecontrol.person_model.PersonGroup;
import com.example.mypc.aaiv_voicecontrol.vision_model.VisionResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import retrofit2.Response;

/**
 * Created by MyPC on 02/06/2017.
 */

public class MainServices {
    private String uploadResponse;
    private String identifyResponse = "Identify Fail";
    private Upload upload;
    private String faceIds = "";
    private StringBuilder stringBuilder = new StringBuilder();

    public String IdentifyPerson(String urlImage) {

        final PersonServices service = new PersonServices();
        List<PersonGroup> personGroups;

        try {

//            personGroups = this.GetPersonGroupSync();
//
//            if (personGroups != null) {

            List<FaceDetectResponse> faceDetectResponses = service.DetectFaces(urlImage).execute().body();
            if (faceDetectResponses != null) {
                List<String> listFaceIds = new ArrayList<>();

                for (FaceDetectResponse faceDetected :
                        faceDetectResponses) {
                    Log.d("Detect", faceDetected.faceId);
                    listFaceIds.add(faceDetected.faceId);
                }

                faceIds = TextUtils.join(",", listFaceIds);

//                    for (PersonGroup personGroup :
//                            personGroups) {

                List<FaceIdentifyResponse> faceIdentifyResponses = service.IdentifyPerson("friend", faceIds).execute().body();

                if (faceIdentifyResponses != null) {

                    for (FaceIdentifyResponse faceIdentified :
                            faceIdentifyResponses) {

                        if (faceIdentified.candidates.size() > 0 || faceIdentified.candidates != null) {

                            Log.d("Identify", "Candidates for faceId: " + faceIdentified.faceId);
                            for (Candidate candidate :
                                    faceIdentified.candidates) {
                                Log.d("Identify", candidate.personId);
                                Person person = service.GetPersonById("friend", candidate.personId).execute().body();
                                if (person != null) {
                                    identifyResponse = person.name;
                                    stringBuilder.append(identifyResponse + " | ");
                                } else {
                                    Log.e("Person", "Can't get person");
                                }
                            }

                        }

                    }

                } else {
                    Toast.makeText(CameraActivity_2.getContext(), "Identify Person Failed", Toast.LENGTH_SHORT).show();
                }
                //}
            } else {
                Toast.makeText(CameraActivity_2.getContext(), "Detect Faces Failed", Toast.LENGTH_SHORT).show();
            }
//            } else {
//                Toast.makeText(CameraActivity_2.getContext(), "No PersonGroup Found", Toast.LENGTH_SHORT).show();
//            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return identifyResponse;
    }

    public List<PersonGroup> GetPersonGroupSync() {
        PersonServices personServices = new PersonServices();
        List<PersonGroup> personGroups = null;
        try {
            Response<List<PersonGroup>> response = personServices.GetPersonGroupSync().execute();
            if (response.isSuccessful()) {
                personGroups = response.body();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return personGroups;
    }


    public VisionResponse DetectVision(String url) {
        VisionResponse visionResponse = null;


        VisionService visionService = new VisionService();
        try {
            Response<VisionResponse> response = visionService.DetectVision(url).execute();
            if (response.isSuccessful()) {
                visionResponse = response.body();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return visionResponse;
    }
}
