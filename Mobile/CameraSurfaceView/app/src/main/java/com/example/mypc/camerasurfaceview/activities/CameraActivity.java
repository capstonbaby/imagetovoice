package com.example.mypc.camerasurfaceview.activities;

import android.Manifest;
import android.annotation.SuppressLint;
import android.app.Application;
import android.content.Context;
import android.hardware.Camera;
import android.hardware.Camera.PictureCallback;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.support.annotation.NonNull;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.Toast;

import com.example.mypc.camerasurfaceview.CameraPreview;
import com.example.mypc.camerasurfaceview.R;
import com.example.mypc.camerasurfaceview.computer_vison_model.Caption;
import com.example.mypc.camerasurfaceview.computer_vison_model.VisionResponse;
import com.example.mypc.camerasurfaceview.helpers.DocumentHelper;
import com.example.mypc.camerasurfaceview.helpers.NotificationHelper;
import com.example.mypc.camerasurfaceview.imgurmodel.ImageResponse;
import com.example.mypc.camerasurfaceview.imgurmodel.Upload;
import com.example.mypc.camerasurfaceview.services.DetectService;
import com.example.mypc.camerasurfaceview.services.UploadService;
import com.example.mypc.camerasurfaceview.utils.NetworkUtils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import okhttp3.MediaType;
import okhttp3.MultipartBody;
import okhttp3.RequestBody;
import permissions.dispatcher.NeedsPermission;
import permissions.dispatcher.RuntimePermissions;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

import static com.example.mypc.camerasurfaceview.activities.MainActivity.getCameraInstance;

@RuntimePermissions
public class CameraActivity extends AppCompatActivity {

    private Camera mCamera;
    private CameraPreview mPreview;

    public static final int MEDIA_TYPE_IMAGE = 1;
    public static final int MEDIA_TYPE_VIDEO = 2;

    private File takenPicture;
    private Upload upload;

    public NotificationHelper notificationHelper = new NotificationHelper(CameraActivity.this);

    public static Application instance;

    public static Context getContext() {
        return instance.getApplicationContext();
    }

    /**
     * Create a file Uri for saving an image or video
     */
    private static Uri getOutputMediaFileUri(int type) {
        return Uri.fromFile(getOutputMediaFile(type));
    }

    /**
     * Create a File for saving an image or video
     */
    private static File getOutputMediaFile(int type) {
        // To be safe, you should check that the SDCard is mounted
        // using Environment.getExternalStorageState() before doing this.

        File mediaStorageDir = new File(Environment.getExternalStoragePublicDirectory(
                Environment.DIRECTORY_PICTURES), "MyCameraApp");
        // This location works best if you want the created images to be shared
        // between applications and persist after your app has been uninstalled.

        // Create the storage directory if it does not exist
        if (!mediaStorageDir.exists()) {
            if (!mediaStorageDir.mkdirs()) {
                Log.d("MyCameraApp", "failed to create directory");
                return null;
            }
        }

        // Create a media file name
        String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
        File mediaFile;
        if (type == MEDIA_TYPE_IMAGE) {
            mediaFile = new File(mediaStorageDir.getPath() + File.separator +
                    "IMG_" + timeStamp + ".jpg");
        } else if (type == MEDIA_TYPE_VIDEO) {
            mediaFile = new File(mediaStorageDir.getPath() + File.separator +
                    "VID_" + timeStamp + ".mp4");
        } else {
            return null;
        }

        return mediaFile;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_camera);
        CameraActivityPermissionsDispatcher.showCameraWithCheck(this);

    }

    @NeedsPermission({Manifest.permission.CAMERA, Manifest.permission.WRITE_EXTERNAL_STORAGE,
            Manifest.permission.ACCESS_NETWORK_STATE,
            Manifest.permission.INTERNET, Manifest.permission.READ_EXTERNAL_STORAGE})
    void showCamera() {
        mCamera = getCameraInstance();
        mPreview = new CameraPreview(this, mCamera);
        FrameLayout preview = (FrameLayout) findViewById(R.id.camera_preview);
        preview.addView(mPreview);

        FrameLayout frameLayout = (FrameLayout) findViewById(R.id.camera_preview);
        frameLayout.setOnClickListener(
                new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        mCamera.takePicture(null, null, mPicture);
                    }
                }
        );
    }

    private PictureCallback mPicture = new PictureCallback() {

        @Override
        public void onPictureTaken(byte[] data, Camera camera) {

            File pictureFile = getOutputMediaFile(MEDIA_TYPE_IMAGE);
            Uri pictureUri = Uri.fromFile(pictureFile);
            String filePath = DocumentHelper.getPath(CameraActivity.this, pictureUri);

            if (pictureFile == null) {
                Toast.makeText(CameraActivity.this, "Error creating media file, check storage permissions", Toast.LENGTH_LONG).show();
                return;
            }

            try {
                FileOutputStream fos = new FileOutputStream(pictureFile);
                fos.write(data);
                fos.close();


            } catch (FileNotFoundException e) {
                Toast.makeText(CameraActivity.this, "File not found !", Toast.LENGTH_LONG).show();
            } catch (IOException e) {
                Toast.makeText(CameraActivity.this, "Error accessing file !", Toast.LENGTH_LONG).show();
            }

            if (filePath != null || !filePath.isEmpty()) {
                takenPicture = new File(filePath);
                createUpload(takenPicture);

                notificationHelper.createUploadingNotification();
                if (NetworkUtils.isConnected(CameraActivity.this)) {

                    MultipartBody.Part body = MultipartBody.Part.createFormData(
                            "image",
                            upload.image.getName(),
                            RequestBody.create(MediaType.parse("image/*"), upload.image)
                    );

                    Call<ImageResponse> imageResponseCall = new UploadService().Execute(body, upload);

                    if (imageResponseCall != null) {
                        imageResponseCall.enqueue(new Callback<ImageResponse>() {
                            @Override
                            public void onResponse(Call<ImageResponse> call, Response<ImageResponse> response) {
                                if (call.isExecuted()) {
                                    if (response == null) {
                                    /*
                                     Notify image was NOT uploaded successfully
                                    */
                                        notificationHelper.createFailedUploadNotification();
                                        return;
                                    }
                                    /*
                                    Notify image was uploaded successfully
                                    */
                                    if (response.isSuccessful()) {

                                        notificationHelper.createUploadedNotification(response);


                                    }
                                }
                            }

                            @Override
                            public void onFailure(Call<ImageResponse> call, Throwable t) {
                                Log.e("Image", "Upload Image Fail");
                            }
                        });
                    }
                }
            }

        }
    };


    public void detectView(Response<ImageResponse> response){
        new DetectService().Execute(response.body().data.link)
                .enqueue(new Callback<VisionResponse>() {
                    @Override
                    public void onResponse(Call<VisionResponse> call, Response<VisionResponse> response) {
                        for (Caption caption : response.body().description.captions) {
                            Log.d("Vision", caption.text);
                            Snackbar snackbar = Snackbar
                                    .make(findViewById(R.id.coordinatorLayout), caption.text, Snackbar.LENGTH_INDEFINITE);
                            snackbar.show();
                        }
                    }

                    @Override
                    public void onFailure(Call<VisionResponse> call, Throwable t) {
                        Log.d("Vision", "FAIL");
                        Toast.makeText(CameraActivity.this, "Can't detect the picture mate !", Toast.LENGTH_LONG).show();
                        releaseCamera();
                        showCamera();
                    }
                });
    }

    public void trainImage(Response<ImageResponse> response){

    }


    private void createUpload(File image) {
        upload = new Upload();

        upload.image = image;
        upload.title = "testing";
    }

    @Override
    protected void onPause() {
        super.onPause();
        releaseCamera();              // release the camera immediately on pause event
    }

    private void releaseCamera() {
        if (mCamera != null) {
            mCamera.release();        // release the camera for other applications
            mCamera = null;
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        setContentView(R.layout.activity_camera);
        CameraActivityPermissionsDispatcher.showCameraWithCheck(this);
    }

    @SuppressLint("NeedOnRequestPermissionsResult")
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        CameraActivityPermissionsDispatcher.onRequestPermissionsResult(this, requestCode, grantResults);
    }

}

