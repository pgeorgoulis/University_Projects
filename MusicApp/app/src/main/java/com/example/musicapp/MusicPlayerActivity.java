 package com.example.musicapp;

import static androidx.constraintlayout.helper.widget.MotionEffect.TAG;

import androidx.appcompat.app.AppCompatActivity;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.media.AudioManager;
import android.media.MediaPlayer;
import android.os.Bundle;
import android.os.Handler;
import android.provider.MediaStore;
import android.util.Log;
import android.widget.ImageView;
import android.widget.SeekBar;
import android.widget.TextView;

import java.io.IOException;
import java.util.ArrayList;
import java.util.concurrent.TimeUnit;

 public class MusicPlayerActivity extends AppCompatActivity {

    TextView titleTextView, currentTimeTextView, totalTimeTextView;
    SeekBar seekBar;
    ImageView pausePlay, nextBtn, prevBtn, musicIcon;

    ArrayList<AudioModel> songsList;
    AudioModel currentSong;
    MediaPlayer mediaPlayer = MyMediaPlayer.getInstance();

    AudioManager audioManager;
    private AudioManager.OnAudioFocusChangeListener afChangeListener;
    int x = 0;



     @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        audioManager = (AudioManager) getSystemService(Context.AUDIO_SERVICE);
         afChangeListener = new AudioManager.OnAudioFocusChangeListener() {
             @Override
             public void onAudioFocusChange(int focusChange) {
                 switch (focusChange){
                     case AudioManager.AUDIOFOCUS_LOSS:
                     case AudioManager.AUDIOFOCUS_LOSS_TRANSIENT:
                     case AudioManager.AUDIOFOCUS_LOSS_TRANSIENT_CAN_DUCK:
                         pausePlay();
                 }
             }
         };

        setContentView(R.layout.activity_music_player);

        titleTextView = findViewById(R.id.song_title);
        currentTimeTextView = findViewById(R.id.current_time);
        totalTimeTextView = findViewById(R.id.total_time);
        seekBar = findViewById(R.id.seek_bar);
        pausePlay = findViewById(R.id.pause);
        nextBtn = findViewById(R.id.next);
        prevBtn = findViewById(R.id.previous);
        musicIcon = findViewById(R.id.music_key);
        songsList =(ArrayList<AudioModel>) getIntent().getSerializableExtra("LIST");

        titleTextView.setSelected(true);

        setResourcesWithMusic();


        MusicPlayerActivity.this.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if(mediaPlayer!=null){
                    seekBar.setProgress(mediaPlayer.getCurrentPosition());
                    currentTimeTextView.setText(convertToMinutes(mediaPlayer.getCurrentPosition()+""));

                    if(mediaPlayer.isPlaying()){
                        pausePlay.setImageResource(R.drawable.baseline_pause_circle_24);
                        musicIcon.setRotation(x++);
                    }else{
                        pausePlay.setImageResource(R.drawable.baseline_play_circle_24);
                        musicIcon.setRotation(0);
                    }
                }
                //this takes some time so delay the process
                new Handler().postDelayed(this, 100);
            }
        });

        seekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int i, boolean b) {
                if(mediaPlayer != null && b){
                    mediaPlayer.seekTo(i);
                }
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {

            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {

            }
        });
    }

    void setResourcesWithMusic(){
        currentSong = songsList.get(MyMediaPlayer.currentIndex);

        titleTextView.setText(currentSong.getTitle());

        totalTimeTextView.setText(convertToMinutes(currentSong.getDuration()));

        pausePlay.setOnClickListener(v-> pausePlay());
        nextBtn.setOnClickListener(v-> playNextSong());
        prevBtn.setOnClickListener(v-> playPrevSong());
        playMusic();
    }


     private void playMusic(){

         // Assuming you're starting playback here
         int result = audioManager.requestAudioFocus(afChangeListener,
                 AudioManager.STREAM_MUSIC, AudioManager.AUDIOFOCUS_GAIN);

         if (result == AudioManager.AUDIOFOCUS_REQUEST_GRANTED) {
             // Proceed with starting playback
             mediaPlayer.start();
         }

         mediaPlayer.reset();
         try {
             mediaPlayer.setDataSource(currentSong.getPath());
             mediaPlayer.prepare();
             mediaPlayer.start();
             seekBar.setProgress(0);
             seekBar.setMax(mediaPlayer.getDuration());
         } catch (IOException e) {
             e.printStackTrace();
         }


     }
     private void playNextSong(){
        //what if its the last song
        if(MyMediaPlayer.currentIndex==songsList.size() - 1){
            return;
        }
        MyMediaPlayer.currentIndex +=1;
        mediaPlayer.reset();
        setResourcesWithMusic();
     }

     private void playPrevSong(){
         if(MyMediaPlayer.currentIndex==0){
             return;
         }
         MyMediaPlayer.currentIndex -=1;
         mediaPlayer.reset();
         setResourcesWithMusic();

     }

     private void pausePlay(){
        if(mediaPlayer.isPlaying()){
            mediaPlayer.pause();
        }else{
            mediaPlayer.start();
        }
     }
    public static String convertToMinutes(String duration){
        Long mils = Long.parseLong(duration);
        return String.format("%02d:%02d",
                TimeUnit.MILLISECONDS.toMinutes(mils) % TimeUnit.HOURS.toMinutes(1),
                TimeUnit.MILLISECONDS.toSeconds(mils) % TimeUnit.MINUTES.toSeconds(1));
    }






}