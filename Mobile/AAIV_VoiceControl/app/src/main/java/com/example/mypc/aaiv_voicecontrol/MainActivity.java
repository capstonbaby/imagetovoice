package com.example.mypc.aaiv_voicecontrol;

import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.Intent;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.speech.RecognizerIntent;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.text.TextUtils;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.bumptech.glide.Glide;
import com.example.mypc.aaiv_voicecontrol.Helper.NotificationHelper;
import com.example.mypc.aaiv_voicecontrol.Utils.NetworkUtil;
import com.example.mypc.aaiv_voicecontrol.imgur_model.ImageResponse;
import com.example.mypc.aaiv_voicecontrol.imgur_model.Upload;
import com.example.mypc.aaiv_voicecontrol.person_model.Candidate;
import com.example.mypc.aaiv_voicecontrol.person_model.FaceDetectResponse;
import com.example.mypc.aaiv_voicecontrol.person_model.FaceIdentifyResponse;
import com.example.mypc.aaiv_voicecontrol.person_model.Person;
import com.example.mypc.aaiv_voicecontrol.person_model.PersonGroup;
import com.example.mypc.aaiv_voicecontrol.services.PersonServices;
import com.example.mypc.aaiv_voicecontrol.services.UploadService;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import okhttp3.MediaType;
import okhttp3.MultipartBody;
import okhttp3.RequestBody;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class MainActivity extends AppCompatActivity {

    private final int SPEECH_RECOGNITION_CODE = 1;

    private SensorManager mSensorManager;
    private Sensor mAccelerometer;
    private ShakeDetector mShakeDetector;

    private TextView txtOutput;
    private FloatingActionButton fab;
    private ImageView iv_preview;

    private String returnImagePath;
    private List<PersonGroup> mPersonGroupList;
    String faceIds = "";

    String uploadResponse;
    Upload upload;
    File takenPicture;
    public NotificationHelper notificationHelper = new NotificationHelper(this);

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        Constants.setApiHost("192.168.1.76");
        Toast.makeText(this, Constants.getApiHost(), Toast.LENGTH_LONG).show();

        iv_preview = (ImageView) findViewById(R.id.iv_preview);
        fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startSpeechToText("Speak your request...");
            }
        });

        Intent intent = getIntent();
        if (intent != null) {
            returnImagePath = intent.getStringExtra("filePath");
            Glide.with(this).load(returnImagePath).into(iv_preview);
            uploadImage(returnImagePath);
        }


        // ShakeDetector initialization
        mSensorManager = (SensorManager) getSystemService(Context.SENSOR_SERVICE);
        mAccelerometer = mSensorManager
                .getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
        mShakeDetector = new ShakeDetector();
        mShakeDetector.setOnShakeListener(new ShakeDetector.OnShakeListener() {

            @Override
            public void onShake(int count) {
                if (count == 2) {
                    Log.e("shake", "SHAKED BABY");
                    startSpeechToText("Speak your request...");
                }
            }
        });

    }

    public void uploadImage(String filePath) {

        if (filePath != null) {
            notificationHelper.createUploadingNotification();

            takenPicture = new File(filePath);
            createUpload(takenPicture);

            if (NetworkUtil.isConnected(this)) {
                MultipartBody.Part body = MultipartBody.Part.createFormData(
                        "image",
                        upload.image.getName(),
                        RequestBody.create(MediaType.parse("image/*"), upload.image)
                );

                new UploadService().Execute(body, upload).enqueue(new Callback<ImageResponse>() {
                    @Override
                    public void onResponse(Call<ImageResponse> call, Response<ImageResponse> response) {
                        if (response == null) {
                            notificationHelper.createFailedUploadNotification();
                        }

                        if (response.isSuccessful()) {
                            notificationHelper.createUploadedNotification(response);
                            uploadResponse = response.body().data.link;
                            startSpeechToText("What now ?");
                        }
                    }

                    @Override
                    public void onFailure(Call<ImageResponse> call, Throwable t) {
                        notificationHelper.createFailedUploadNotification();
                        t.printStackTrace();
                    }
                });
            } else {
                notificationHelper.createFailedUploadNotification();
                Toast.makeText(this, "Cannot Connect To the Internet", Toast.LENGTH_LONG).show();
            }
        } else {
            Toast.makeText(this, "File Path Not Found", Toast.LENGTH_LONG).show();
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        mSensorManager.registerListener(mShakeDetector, mAccelerometer, SensorManager.SENSOR_DELAY_UI);
    }

    @Override
    protected void onPause() {
        mSensorManager.unregisterListener(mShakeDetector);
        super.onPause();
    }

    public void startSpeechToText(String promt) {
        Intent intent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
        intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE, Locale.getDefault());
        intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL,
                RecognizerIntent.LANGUAGE_MODEL_FREE_FORM);
        intent.putExtra(RecognizerIntent.EXTRA_PROMPT, promt);
        intent.putExtra(RecognizerIntent.EXTRA_SPEECH_INPUT_POSSIBLY_COMPLETE_SILENCE_LENGTH_MILLIS, "9000");

        try {
            startActivityForResult(intent, SPEECH_RECOGNITION_CODE);
        } catch (ActivityNotFoundException e) {
            e.printStackTrace();
            Toast.makeText(this, "Speech recognition is not support for this device.", Toast.LENGTH_SHORT).show();
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        switch (requestCode) {
            case SPEECH_RECOGNITION_CODE: {
                if (resultCode == RESULT_OK && null != data) {
                    ArrayList<String> results = data
                            .getStringArrayListExtra(RecognizerIntent.EXTRA_RESULTS);

                    String text = results.get(0);
                    switch (text) {
                        case "capture": {
                            Intent intent = new Intent(this, CameraActivity.class);
                            startActivity(intent);
                            break;
                        }
                        case "create": {
                            Intent intent = new Intent(this, AddPersonActivity.class);
                            intent.putExtra("imageLink", uploadResponse);
                            startActivity(intent);
                            break;
                        }
                        case "who is it": {
                            IdentifyPerson(uploadResponse);
                            break;
                        }
                        default:
                            Toast.makeText(this, "Didn't get that", Toast.LENGTH_LONG).show();
                    }
                }
                break;
            }
        }
    }

    public void IdentifyPerson(String urlImage) {

        final PersonServices service = new PersonServices();

        service.DetectFaces(urlImage).enqueue(new Callback<List<FaceDetectResponse>>() {
            @Override
            public void onResponse(Call<List<FaceDetectResponse>> call, Response<List<FaceDetectResponse>> response) {


                List<String> listFaceIds = new ArrayList<>();

                for (FaceDetectResponse faceDetected :
                        response.body()) {
                    Log.d("Detect", faceDetected.faceId);
                    listFaceIds.add(faceDetected.faceId);
                }

                faceIds = TextUtils.join(",", listFaceIds);

//                service.GetPersonGroups().enqueue(new Callback<List<PersonGroup>>() {
//                    @Override
//                    public void onResponse(Call<List<PersonGroup>> call, Response<List<PersonGroup>> response) {
//                        mPersonGroupList = response.body();
//                        if (mPersonGroupList != null) {
//                            for (final PersonGroup group :
//                                    mPersonGroupList) {
                                service.IdentifyPerson("111", faceIds).enqueue(new Callback<List<FaceIdentifyResponse>>() {
                                    @Override
                                    public void onResponse(Call<List<FaceIdentifyResponse>> call, Response<List<FaceIdentifyResponse>> response) {
                                        for (FaceIdentifyResponse faceIdentified :
                                                response.body()) {
                                            Log.d("Identify", "Candidates for faceId: " + faceIdentified.faceId);
                                            for (Candidate candidate :
                                                    faceIdentified.candidates) {
                                                Log.d("Identify", candidate.personId);
                                                service.GetPersonById("111", candidate.personId)
                                                        .enqueue(new Callback<Person>() {
                                                            @Override
                                                            public void onResponse(Call<Person> call, Response<Person> response) {
                                                                Log.d("Person", response.body().name);
                                                                Log.d("Person", response.body().userData);

                                                                Toast.makeText(MainActivity.this,
                                                                        response.body().name + ". " + response.body().userData, Toast.LENGTH_LONG).show();
                                                            }

                                                            @Override
                                                            public void onFailure(Call<Person> call, Throwable t) {
                                                                Log.e("Person", "Can't get person");
                                                                Toast.makeText(MainActivity.this, "Can't get identified person", Toast.LENGTH_LONG).show();
                                                            }
                                                        });
                                            }
                                        }
                                    }

                                    @Override
                                    public void onFailure(Call<List<FaceIdentifyResponse>> call, Throwable t) {
                                        Toast.makeText(MainActivity.this, "Identify Person Failed", Toast.LENGTH_SHORT).show();
                                        t.printStackTrace();
                                    }
                                });
//                            }
//                        } else {
//                            Toast.makeText(MainActivity.this, "Cannot get person groups", Toast.LENGTH_SHORT).show();
//                        }
//                    }
//
//                    @Override
//                    public void onFailure(Call<List<PersonGroup>> call, Throwable t) {
//                        Toast.makeText(MainActivity.this, "Cannot get person groups", Toast.LENGTH_SHORT).show();
//                    }
//                });
            }

            @Override
            public void onFailure(Call<List<FaceDetectResponse>> call, Throwable t) {
                Toast.makeText(MainActivity.this, "Detect Faces Failed", Toast.LENGTH_SHORT).show();
                t.printStackTrace();
            }
        });
    }


    private void createUpload(File image) {
        upload = new Upload();

        upload.image = image;
        upload.title = "testing";
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}








