package com.example.mypc.camerasurfaceview.activities;

import android.content.Context;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.Toast;

import com.example.mypc.camerasurfaceview.R;
import com.example.mypc.camerasurfaceview.face_detect_model.PersonGroup;
import com.example.mypc.camerasurfaceview.services.IdentifyService;

import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class TrainActivity extends AppCompatActivity implements AdapterView.OnItemSelectedListener {

    public static Context instance;

    public static Context getContext() {
        return instance;
    }

    String personGroupId;
    Spinner spinner;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_train);

        instance = getApplicationContext();

        new IdentifyService().GetPersonGroups().enqueue(new Callback<List<PersonGroup>>() {
            @Override
            public void onResponse(Call<List<PersonGroup>> call, Response<List<PersonGroup>> response) {
                spinner = (Spinner) findViewById(R.id.sp_person_group);
                spinner.setOnItemSelectedListener(TrainActivity.this);

                ArrayAdapter<PersonGroup> dataAdapter =
                        new ArrayAdapter<>(TrainActivity.this, android.R.layout.simple_spinner_item, response.body());
                dataAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
                spinner.setAdapter(dataAdapter);
            }

            @Override
            public void onFailure(Call<List<PersonGroup>> call, Throwable t) {
                Toast.makeText(TrainActivity.this, "Get Groups Fail", Toast.LENGTH_LONG).show();
            }
        });


    }

    @Override
    public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
        PersonGroup item = (PersonGroup) parent.getItemAtPosition(position);
        personGroupId = item.personGroupId;

        Toast.makeText(this, "Group: " + item.name + ". Des: " +item.userData, Toast.LENGTH_SHORT).show();
    }

    @Override
    public void onNothingSelected(AdapterView<?> parent) {

    }

    public void TrainGroup(View view) {
        new IdentifyService().TrainPersonGroup(personGroupId);
    }
}
