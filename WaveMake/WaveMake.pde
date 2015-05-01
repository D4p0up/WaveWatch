import ddf.minim.analysis.*;
import ddf.minim.*;
import ddf.minim.signals.*;
import static javax.swing.JOptionPane.*;

/*Waveform Buffer*/
float[] wave_A;
float[] wave_B;
int waveform_A=0;
int waveform_B=0;
float amp_A=1;
float amp_B=1;
float freq_A=440;
int ext_A=1;
float freq_B=220;
int ext_B=0;
float delta_acc_A=2048*(freq_A)/44100;
float delta_acc_B=2048*(freq_B)/44100;
float phase_acc_A=0;
float phase_acc_B=0;

boolean wA_on=false;
boolean wB_on=false;

// Splash
PImage splash;
int dfade=235;

// Audio
Minim minim;
AudioOutput out;
WaveformRenderer waveform;

void setup() {
  wave_A = new float[2048];
  setSin(wave_A);
  wave_B = new float[2048];
  setSin(wave_B);
  size(266, 256);
  minim = new Minim(this);
  out = minim.getLineOut(Minim.STEREO, 512, 44100);
  waveform = new WaveformRenderer();
  out.addSignal( waveform );
  splash = loadImage("data/splash.jpg");
}


