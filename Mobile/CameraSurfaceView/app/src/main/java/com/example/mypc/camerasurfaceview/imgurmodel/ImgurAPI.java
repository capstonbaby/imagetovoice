package com.example.mypc.camerasurfaceview.imgurmodel;


import okhttp3.MultipartBody;
import retrofit2.Call;
import retrofit2.http.Header;
import retrofit2.http.Multipart;
import retrofit2.http.POST;
import retrofit2.http.Part;
import retrofit2.http.Query;

/**
 * Created by AKiniyalocts on 2/23/15.
 * <p/>
 * This is our imgur API. It generates a rest API via Retrofit from Square inc.
 * <p/>
 * more here: http://square.github.io/retrofit/
 */
public interface ImgurAPI {
    String server = "https://api.imgur.com";


    /****************************************
     * Upload
     * Image upload API
     */

    /**
     * @param auth        #Type of authorization for upload
     * @param title       #Title of image
     * @param description #Description of image
     * @param albumId     #ID for album (if the user is adding this image to an album)
     * @param username    username for upload
     */
    @Multipart
    @POST("/3/image")
    Call<ImageResponse> postImage(
            @Header("Authorization") String auth,
            @Query("title") String title,
            @Query("description") String description,
            @Query("album") String albumId,
            @Query("account_url") String username,
            @Part MultipartBody.Part file
    );
}
