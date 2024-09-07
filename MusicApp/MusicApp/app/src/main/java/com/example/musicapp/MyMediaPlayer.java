package com.example.musicapp;

import android.media.MediaPlayer;

//this is a signleton class
public class MyMediaPlayer {
    static MediaPlayer instance;

    public static MediaPlayer getInstance(){
        if(instance == null){
            instance = new MediaPlayer();
        }
        return instance;
    }

    //it means the song is not clicked yet
    public static int currentIndex = -1;

}
