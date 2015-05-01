/* 
 ==================================================
  _      __             _      __     __      __ 
 | | /| / /__ __  _____| | /| / /__ _/ /_____/ / 
 | |/ |/ / _ `/ |/ / -_) |/ |/ / _ `/ __/ __/ _ \
 |__/|__/\_,_/|___/\__/|__/|__/\_,_/\__/\__/_//_/

 Open Source Souncard Oscilloscope by Banson
 Background image by Humusak
 V1.2
 
 http://www.banson.fr/wiki/doku.php?id=wavewatch
  
 =================================================
 Provided under the following license: by-nc-sa
 http://creativecommons.org/licenses/by-nc-sa/4.0/
 =================================================
 
Basic Controls :
 'u' and 'j' : Turn Left & Right Channel ON and OFF
 'e' and 'd' : Left Channel Gain
 'r' and 'f' : Right CHannel Gain
 'c' and 'v' : Time Base adjusting
 mouse click on leftmost or rightmost points of the window moves Channel origin

Advanced Controls :
 't' and 'g' : Trigger level adjustment
 'h' : Toggles triggering from channel A to channel B
 'b' : Activates measurement cursors
 'y' : Toggles between Auto and Single mode
 spacebar : Pause and Resume
 
And of course :
 'o' : Exit Scope
 
 */

import ddf.minim.analysis.*;
import ddf.minim.*;
import ddf.minim.signals.*;
import static javax.swing.JOptionPane.*;

Minim minim;
AudioInput in;

// Interface Voltage Tuning 
float linelevel1;
float linelevel2;
float vp1;
float vp2;
String[] lines;
PrintWriter output;

// Images
PImage splash;

// Status and Trig
boolean trig_en = false;
boolean trig_dir = true;
boolean trigged = false;
boolean stopped = false;
boolean once = false;
float triglevel = 0.000;
int trigdelta=0;
boolean trigin = false;
boolean alignment=false;
int started=0;

// Measurement
int mesure=0;
int m1X;
int m1Y;
int m2X;
int m2Y;

int dfade=235;

// Gain and Timebase
float gain1 = 200;
float gain2 = 200;

float[] tbase_list = {
  0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 50, 100, 200, 500
};
int i_tbase = 4;
float tbase = tbase_list[i_tbase]*44100/40000;

// Frequency Calculation 
float freq1 = 0;
//boolean freqval1=false; 
float freq2 = 0;
//boolean freqval2=false; 

boolean monostereo=false;

// Signal Left
float[] display11;
float[] l_buffer;
boolean Ldisplay=true;
// Signal Right
float[] display21;
float[] r_buffer;
boolean Rdisplay=true;

float display=1;

float I=0;
float J=0;
float K=0;

int offset1=240;
int offset2=240;

// Audio Buffer Size
int A_Buffer=512;
// Data buffer size
int D_Buffer=2048;
// Windows width and height
int W_Width=512;
int W_Height=480;

WaveformRenderer waveform;

void setup()
{
  size(W_Width, W_Height+20, P3D);

  splash = loadImage("data/splash.jpg");

  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, A_Buffer, 44100);

  waveform = new WaveformRenderer();
  in.addListener( waveform );

  display11 = new float[W_Width];
  display21 = new float[W_Width];
  l_buffer = new float[D_Buffer];
  r_buffer = new float[D_Buffer];  
  
  // Load Tuning Data
  // Load Data
  lines = loadStrings("voltage.tsv");
  String[] pieces = split(lines[0], TAB);
  linelevel1 = float(pieces[1]);
  pieces = split(lines[1], TAB);
  linelevel2 = float(pieces[1]);
  pieces = split(lines[2], TAB);
  vp1 = float(pieces[1]);
  pieces = split(lines[3], TAB);
  vp2 = float(pieces[1]);
  
}





