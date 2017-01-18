package com.example.mypc.camerasurfaceview.services;

import android.content.Context;
import android.text.TextUtils;
import android.util.Log;
import android.widget.Toast;

import com.example.mypc.camerasurfaceview.Constants;
import com.example.mypc.camerasurfaceview.activities.MainActivity;
import com.example.mypc.camerasurfaceview.activities.TrainActivity;
import com.example.mypc.camerasurfaceview.face_detect_model.Candidate;
import com.example.mypc.camerasurfaceview.face_detect_model.FaceDetectResponse;
import com.example.mypc.camerasurfaceview.face_detect_model.FaceIdentifyResponse;
import com.example.mypc.camerasurfaceview.face_detect_model.Person;
import com.example.mypc.camerasurfaceview.face_detect_model.PersonGroup;
import com.example.mypc.camerasurfaceview.face_detect_model.face_detect_api;
import com.example.mypc.camerasurfaceview.helpers.NotificationHelper;

import java.util.ArrayList;
import java.util.List;

import okhttp3.OkHttpClient;
import okhttp3.logging.HttpLoggingInterceptor;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

/**
 * Created by MyPC on 01/12/2017.
 */

public class IdentifyService {
    public NotificationHelper notificationHelper;
    Context trainContext = new TrainActivity().getContext();

    public void Execute(String imageUrl) {

        Retrofit retrofit = getRetrofitFaceDetect();

        final face_detect_api faceDetectApi = retrofit.create(face_detect_api.class);

        faceDetectApi.dectectPerson(imageUrl).enqueue(new Callback<List<FaceDetectResponse>>() {


            @Override
            public void onResponse(Call<List<FaceDetectResponse>> call, Response<List<FaceDetectResponse>> response) {
                String faceIds = "";

                List<String> listFaceIds = new ArrayList<>();

                for (FaceDetectResponse faceDetected :
                        response.body()) {
                    Log.d("Detect", faceDetected.faceId);
                    listFaceIds.add(faceDetected.faceId);
                }

                faceIds = TextUtils.join(",", listFaceIds).toString();

                faceDetectApi.identifyPerson("111", faceIds)
                        .enqueue(new Callback<List<FaceIdentifyResponse>>() {
                            @Override
                            public void onResponse(Call<List<FaceIdentifyResponse>> call, Response<List<FaceIdentifyResponse>> response) {
                                for (FaceIdentifyResponse faceIdentified :
                                        response.body()) {
                                    Log.d("Identify", "Candidates for faceId: " + faceIdentified.faceId);
                                    for (Candidate candidate :
                                            faceIdentified.candidates) {
                                        Log.d("Identify", candidate.personId);
                                        faceDetectApi.getPersonById("111", candidate.personId)
                                                .enqueue(new Callback<Person>() {
                                                    @Override
                                                    public void onResponse(Call<Person> call, Response<Person> response) {
                                                        Log.d("Person", response.body().name);
                                                        Log.d("Person", response.body().userData);

                                                        Toast.makeText(MainActivity.getContext(),
                                                                response.body().name + ". " + response.body().userData, Toast.LENGTH_LONG).show();
                                                    }

                                                    @Override
                                                    public void onFailure(Call<Person> call, Throwable t) {
                                                        Log.e("Person", "Can't get person");
                                                        Toast.makeText(MainActivity.getContext(), "Can't get identified person", Toast.LENGTH_LONG).show();
                                                    }
                                                });
                                    }
                                }
                            }

                            @Override
                            public void onFailure(Call<List<FaceIdentifyResponse>> call, Throwable t) {
                                Log.e("Identify", "Can't identify detected faces");
                                Toast.makeText(MainActivity.getContext(), "Can't identify detected faces", Toast.LENGTH_LONG).show();
                            }


                        });
            }

            @Override
            public void onFailure(Call<List<FaceDetectResponse>> call, Throwable t) {
                Log.e("Detect", "Detect Fail");
                t.printStackTrace();
                Toast.makeText(MainActivity.getContext(), "Can't detect any Faces", Toast.LENGTH_LONG).show();
            }
        });

    }

    public Call<List<PersonGroup>> GetPersonGroups() {

        Retrofit retrofit = getRetrofitFaceDetect();

        face_detect_api faceDetectApi = retrofit.create(face_detect_api.class);

        return faceDetectApi.getPersonGroup();
    }

    public Call<List<Person>> GetPeopleInGroup(String personGroupId) {

        Retrofit retrofit = getRetrofitFaceDetect();

        face_detect_api faceDetectApi = retrofit.create(face_detect_api.class);

        Call<List<Person>> call = faceDetectApi.getPeopleInGroup(personGroupId);

        return call;
    }

    public void TrainPersonGroup(String personGroupId) {
        Retrofit retrofit = getRetrofitFaceDetect();
        face_detect_api faceDetectApi = retrofit.create(face_detect_api.class);

        notificationHelper = new NotificationHelper(trainContext);
        notificationHelper.createTrainingStatusNotification();

        faceDetectApi.trainPersonGroup(personGroupId)
                .enqueue(new Callback<Void>() {
                    @Override
                    public void onResponse(Call<Void> call, Response<Void> response) {

                        Toast.makeText(trainContext, "Train Completed", Toast.LENGTH_LONG).show();
                    }

                    @Override
                    public void onFailure(Call<Void> call, Throwable t) {
                        Toast.makeText(trainContext, "Train Failed", Toast.LENGTH_LONG).show();
                    }
                });
    }

    public Retrofit getRetrofitFaceDetect() {
        HttpLoggingInterceptor logging = new HttpLoggingInterceptor();
        logging.setLevel(HttpLoggingInterceptor.Level.BODY);

        OkHttpClient client = new OkHttpClient().newBuilder()
                .addInterceptor(logging)
                .build();

        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl(Constants.getFaceAPIString())
                .addConverterFactory(GsonConverterFactory.create())
                .client(client)
                .build();

        return retrofit;
    }

}
