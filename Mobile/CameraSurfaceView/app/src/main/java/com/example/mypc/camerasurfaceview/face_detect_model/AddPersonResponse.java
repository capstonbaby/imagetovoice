package com.example.mypc.camerasurfaceview.face_detect_model;

/**
 * Created by MyPC on 01/18/2017.
 */

public class AddPersonResponse {
    String persistedFaceId;

    public AddPersonResponse(String persistedFaceId) {
        this.persistedFaceId = persistedFaceId;
    }

    public String getPersistedFaceId() {
        return persistedFaceId;
    }
}
