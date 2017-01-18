package com.example.mypc.camerasurfaceview.services;

import com.example.mypc.camerasurfaceview.Constants;
import com.example.mypc.camerasurfaceview.imgurmodel.ImageResponse;
import com.example.mypc.camerasurfaceview.imgurmodel.ImgurAPI;
import com.example.mypc.camerasurfaceview.imgurmodel.Upload;

import okhttp3.MultipartBody;
import retrofit2.Call;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;


/**
 * Created by AKiniyalocts on 1/12/15.
 * <p/>
 * Our upload service. This creates our restadapter, uploads our image, and notifies us of the response.
 */
public class UploadService {
    public final static String TAG = UploadService.class.getSimpleName();

    public Call<ImageResponse> Execute(MultipartBody.Part body, Upload upload) {

        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl(ImgurAPI.server)
                .addConverterFactory(GsonConverterFactory.create())
                .build();

        ImgurAPI imgurAPI = retrofit.create(ImgurAPI.class);


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

