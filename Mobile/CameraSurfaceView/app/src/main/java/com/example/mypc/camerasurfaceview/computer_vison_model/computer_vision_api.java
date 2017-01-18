package com.example.mypc.camerasurfaceview.computer_vison_model;


import retrofit2.Call;
import retrofit2.http.Field;
import retrofit2.http.FormUrlEncoded;
import retrofit2.http.POST;

/**
 * Created by MyPC on 01/09/2017.
 */

public interface computer_vision_api {

    @FormUrlEncoded
    @POST("detect")
    Call<VisionResponse> detectPiture(@Field("url") String url);

}
