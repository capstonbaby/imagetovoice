package com.example.mypc.camerasurfaceview.services;

import com.example.mypc.camerasurfaceview.Constants;
import com.example.mypc.camerasurfaceview.computer_vison_model.VisionResponse;
import com.example.mypc.camerasurfaceview.computer_vison_model.computer_vision_api;

import okhttp3.OkHttpClient;
import okhttp3.logging.HttpLoggingInterceptor;
import retrofit2.Call;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

/**
 * Created by MyPC on 01/09/2017.
 */

public class DetectService {

    public Call<VisionResponse> Execute(String url) {

        HttpLoggingInterceptor logging = new HttpLoggingInterceptor();
        logging.setLevel(HttpLoggingInterceptor.Level.BASIC);

        OkHttpClient client = new OkHttpClient().newBuilder()
                .addInterceptor(logging)
                .build();

        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl(Constants.getVisionAPIString())
                .addConverterFactory(GsonConverterFactory.create())
                .client(client)
                .build();


        computer_vision_api computerVisionApi = retrofit.create(computer_vision_api.class);

        return computerVisionApi.detectPiture(url);

    }

}
