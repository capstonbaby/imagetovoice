package com.example.mypc.camerasurfaceview.activities;

import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.hardware.Camera;
import android.os.Bundle;
import android.support.design.widget.TextInputLayout;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Toast;

import com.example.mypc.camerasurfaceview.Constants;
import com.example.mypc.camerasurfaceview.R;
import com.example.mypc.camerasurfaceview.services.IdentifyService;


public class MainActivity extends AppCompatActivity {

    public static Context context;

    public static Context getContext() {
        return context;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        context = getApplicationContext();
    }

    public static Camera getCameraInstance() {
        Camera c = null;

        try {
            c = Camera.open();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return c;

    }


    private boolean checkCameraHardware(Context context) {
        if (context.getPackageManager().hasSystemFeature(PackageManager.FEATURE_CAMERA_ANY)) {
            //device has cam
            return true;
        } else {
            //no cam on device
            return false;
        }
    }


    public void openViewDetect(View view) {
        Intent viewDetectIntent = new Intent(this, CameraActivity.class);
        viewDetectIntent.putExtra("Mode", "View");
        startActivity(viewDetectIntent);
    }

    public void openFaceDetect(View view) {
        new IdentifyService()
                .Execute("https://upload.wikimedia.org/wikipedia/commons/5/5d/Barack_Obama_family_portrait_2011.jpg");
    }

    public void openTrain(View view) {
        Intent trainIntennt = new Intent(this, TrainActivity.class);
        startActivity(trainIntennt);
    }

    public void setIpAddress(View view) {
        TextInputLayout textInputLayout = (TextInputLayout) findViewById(R.id.layout_IP);
        String ip = textInputLayout.getEditText().getText().toString();

        Constants.setApiHost(ip);
        Toast.makeText(this, "Saved, the ip is: " + Constants.getApiHost(), Toast.LENGTH_LONG).show();
    }


    public void openAddPerson(View view) {
        Intent addPersonIntent = new Intent(this, AddPersonActivity.class);
        startActivity(addPersonIntent);
    }
}
