package com.example.mypc.aaiv_voicecontrol.services;


import com.example.mypc.aaiv_voicecontrol.Constants;
import com.example.mypc.aaiv_voicecontrol.imgur_model.ImageResponse;
import com.example.mypc.aaiv_voicecontrol.imgur_model.ImgurApi;
import com.example.mypc.aaiv_voicecontrol.imgur_model.Upload;

import java.io.File;

import okhttp3.MultipartBody;
import okhttp3.OkHttpClient;
import okhttp3.logging.HttpLoggingInterceptor;
import retrofit2.Call;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

/**
 * Created by MyPC on 01/21/2017.
 */

public class UploadService {
    public final static String TAG = UploadService.class.getSimpleName();

    public Call<ImageResponse> Execute(MultipartBody.Part body, Upload upload) {

        HttpLoggingInterceptor logging = new HttpLoggingInterceptor();
        logging.setLevel(HttpLoggingInterceptor.Level.BODY);

        OkHttpClient client = new OkHttpClient().newBuilder()
                .addInterceptor(logging)
                .build();

        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl(ImgurApi.server)
                .addConverterFactory(GsonConverterFactory.create())
                .client(client)
                .build();

        ImgurApi imgurAPI = retrofit.create(ImgurApi.class);


        Call<ImageResponse> call = imgurAPI.postImage(
                Constants.getClientAuth(),
                upload.title,
                upload.description,
                upload.albumId,
                null,
                body
        );

        return call;
    }

}
