package com.example.mypc.aaiv_voicecontrol;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.Snackbar;
import android.support.design.widget.TextInputLayout;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.bumptech.glide.Glide;
import com.example.mypc.aaiv_voicecontrol.person_model.AddPersonFaceResponse;
import com.example.mypc.aaiv_voicecontrol.person_model.AddPersonResponse;
import com.example.mypc.aaiv_voicecontrol.person_model.PersonApi;
import com.example.mypc.aaiv_voicecontrol.person_model.PersonGroup;
import com.example.mypc.aaiv_voicecontrol.services.PersonServices;

import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class AddPersonActivity extends AppCompatActivity implements AdapterView.OnItemSelectedListener {

    private String mImageLink;
    private TextInputLayout txtPersonName;
    private TextInputLayout txtPersonDes;
    private Spinner sp_personGroups;
    private ImageView iv_person;
    private Button bt_cretePerson;

    private String personGroupId;

    public static Context context;

    public static Context getContext() {
        return context;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_person);

        context = getApplicationContext();

        Constants.setApiHost("192.168.1.76");
        Toast.makeText(this, Constants.getApiHost(), Toast.LENGTH_LONG).show();

        txtPersonName = (TextInputLayout) findViewById(R.id.input_layout_name);
        txtPersonDes = (TextInputLayout) findViewById(R.id.input_layout_des);
        sp_personGroups = (Spinner) findViewById(R.id.sp_person_group);
        iv_person = (ImageView) findViewById(R.id.iv_person_preview);
        bt_cretePerson = (Button) findViewById(R.id.bt_create);

        sp_personGroups.setOnItemSelectedListener(AddPersonActivity.this);

        new PersonServices().GetPersonGroups().enqueue(new Callback<List<PersonGroup>>() {
            @Override
            public void onResponse(Call<List<PersonGroup>> call, Response<List<PersonGroup>> response) {
                ArrayAdapter<PersonGroup> dataAdapter =
                        new ArrayAdapter<>(AddPersonActivity.this, android.R.layout.simple_spinner_item, response.body());
                dataAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
                sp_personGroups.setAdapter(dataAdapter);
            }

            @Override
            public void onFailure(Call<List<PersonGroup>> call, Throwable t) {
                Toast.makeText(AddPersonActivity.this, "Cannot get Person Groups", Toast.LENGTH_LONG).show();
            }
        });

        Intent intent = getIntent();
        if (intent != null) {
            mImageLink = intent.getStringExtra("imageLink");

            if (mImageLink != null) {
                Glide.with(this).load(mImageLink).centerCrop().into(iv_person);
            }
        }

        bt_cretePerson.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Log.d("GroupId", txtPersonName + " | " + personGroupId);
                CreatePerson(
                        txtPersonName.getEditText().getText().toString(),
                        txtPersonDes.getEditText().getText().toString(),
                        personGroupId,
                        mImageLink
                );
            }
        });

    }

    @Override
    public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
        PersonGroup item = (PersonGroup) parent.getItemAtPosition(position);
        personGroupId = item.getPersonGroupId();
        Log.d("GroupId", item.getPersonGroupId() + " | " + item.name);
    }

    @Override
    public void onNothingSelected(AdapterView<?> parent) {

    }

    public void CreatePerson(String name, final String des, final String personGroupId, final String urlImage) {

        new PersonServices().CreatePerson(name, des, personGroupId).enqueue(new Callback<AddPersonResponse>() {
            @Override
            public void onResponse(Call<AddPersonResponse> call, Response<AddPersonResponse> response) {
                if (response.isSuccessful()) {
                    Toast.makeText(AddPersonActivity.this, response.body().getPersonId(), Toast.LENGTH_LONG).show();

                    new PersonServices().AddPersonFace(personGroupId, response.body().getPersonId(), urlImage, des)
                            .enqueue(new Callback<AddPersonFaceResponse>() {
                                @Override
                                public void onResponse(Call<AddPersonFaceResponse> call, Response<AddPersonFaceResponse> response) {
                                    if (response.isSuccessful()) {
                                        Toast.makeText(AddPersonActivity.this, "Done !", Toast.LENGTH_SHORT).show();
                                        new PersonServices().TrainPersonGroup(personGroupId);
                                    }
                                }

                                @Override
                                public void onFailure(Call<AddPersonFaceResponse> call, Throwable t) {
                                    Toast.makeText(AddPersonActivity.this, "Add person face failed", Toast.LENGTH_LONG).show();
                                }
                            });

                } else {
                    Toast.makeText(AddPersonActivity.this, "Create Person Failed", Toast.LENGTH_LONG).show();
                }
            }

            @Override
            public void onFailure(Call<AddPersonResponse> call, Throwable t) {
                Toast.makeText(AddPersonActivity.this, "Create Person Process Failed", Toast.LENGTH_LONG).show();
                t.printStackTrace();
            }
        });
    }
}
