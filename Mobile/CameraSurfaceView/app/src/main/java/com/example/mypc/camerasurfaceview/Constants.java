package com.example.mypc.camerasurfaceview;

/**
 * Created by AKiniyalocts on 2/23/15.
 */
public class Constants {

    //API Host link
    public static String API_HOST;
    public static final String VISION_API = "vision/";
    public static final String FACE_API = "face/";


    public static void setApiHost(String hostApi) {
        API_HOST = "http://" + hostApi + "/CapstoneProject.WebAPI/api/";
    }

    public static String getApiHost() {
        return API_HOST;
    }

    public static String getVisionAPIString(){
        return API_HOST + VISION_API;
    }

    public static String getFaceAPIString(){
        return API_HOST + FACE_API;
    }

    /*
                  Logging flag
                 */
    public static final boolean LOGGING = false;

    /*
      Your imgur client id. You need this to upload to imgur.

      More here: https://api.imgur.com/
     */
    public static final String MY_IMGUR_CLIENT_ID = "e20a8db5cb7ce3a";
    public static final String MY_IMGUR_CLIENT_SECRET = "6878272532c0061c504f236e01029d7465ee1dbc";

    /*
      Redirect URL for android.
     */
    public static final String MY_IMGUR_REDIRECT_URL = "http://android";

    /*
      Client Auth
     */
    public static String getClientAuth() {
        return "Client-ID " + MY_IMGUR_CLIENT_ID;
    }

}
