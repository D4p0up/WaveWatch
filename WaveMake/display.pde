void draw() {
  background(0);
  strokeJoin(ROUND);
  strokeWeight(2);
  
  if (dfade>0) dfade=dfade-1;
  tint(255, 48+dfade);
  image(splash, 0, 0);
  
  // Waveforms Horizontal line
  stroke(96,32,32);
  line(0,64,128,64);
  stroke(32,96,32);
  line(0,192,128,192);  
  
  // Channel A waveform (Left)
  if (wA_on) stroke(255,128,128); else stroke(148,128,128);
  for(int i=0;i<128;i=i+1){
    line(i,64-56*wave_A[16*i]*amp_A,i+1,64-56*wave_A[16*i+15]*amp_A);
  }
  stroke(255,128,128);
  
  // Channel A Level
  line(128,128-amp_A*120,148,128-amp_A*120);
  // Channel A Frequency
  if (ext_A==0) line(248,128-freq_A/2,268,128-freq_A/2);  
  if (ext_A==1) line(248,128-freq_A/20,268,128-freq_A/20);
  if (ext_A==2) line(248,128-freq_A/200,268,128-freq_A/200);
  
  // Channel B waveform (right)
  if (wB_on) stroke(128,255,128); else stroke(128,148,128);
  for(int i=0;i<128;i=i+1){
    line(i,192-56*wave_B[16*i]*amp_B,i+1,192-56*wave_B[16*i+15]*amp_B);
  }
  stroke(128,255,128);
  
  // Channel B Level
  line(128,256-amp_B*120,148,256-amp_B*120);
  // Channel B Frequency
  if (ext_B==0) line(248,256-freq_B/2,268,256-freq_B/2);
  if (ext_B==1) line(248,256-freq_B/20,268,256-freq_B/20);
  if (ext_B==2) line(248,256-freq_B/200,268,256-freq_B/200);
  
  // Horizontal and vertical GUI Lines
  stroke(128,128,128);
  line(0,128,512,128);
  line(128,0,128,256);
  line(148,0,148,256);
  line(248,0,248,256);
  line(268,0,268,256);

  // Waveform A Displays
  fill(255,128,128);
  stroke(128,128,128);
  line(148,20,248,20);
  line(148,40,248,40);
  text("A:"+amp_A,154,14);
  text("F:"+freq_A+"Hz",154,35);
  
  // Waveform A Freq Range
  line(148,60,248,60);
  fill(128,128,128);
  if (ext_A==0) fill(255,128,128); 
  text("220",156,55);
  if (ext_A==0) fill(128,128,128); 
  line(182,60,182,40);
  if (ext_A==1) fill(255,128,128);
  text("2.2k",188,55);
  if (ext_A==1) fill(128,128,128);
  line(215,60,215,40);
  if (ext_A==2) fill(255,128,128);
  text("22k",223,55);  
  
  // Waveform B Displays
  fill(128,255,128);
  stroke(128,128,128);
  line(148,148,248,148);
  line(148,168,248,168);
  text("A:"+amp_B,154,14+128);
  text("F:"+freq_B+"Hz",154,35+128); 
 
  // Waveform B Freq Range  
  line(148,188,248,188);
  fill(128,128,128);
  if (ext_B==0) fill(128,255,128); 
  text("220",156,55+128);
  if (ext_B==0) fill(128,128,128); 
  line(182,188,182,168);
  if (ext_B==1) fill(128,255,128);
  text("2.2k",188,55+128);
  if (ext_B==1) fill(128,128,128);
  line(215,188,215,168);
  if (ext_B==2) fill(128,255,128);
  text("22k",223,55+128);    
  
  // Waveform A Selection
  fill(255,128,128);  
  line(148,80,248,80);
  line(182,60,182,80);
  line(215,60,215,80);
  if(waveform_A==0) fill(255,128,128);
  else fill(128,128,128);
  text("SIN",156,75);
  if(waveform_A==1) fill(255,128,128);
  else fill(128,128,128);
  text("TRI",189,75);
  if(waveform_A==2) fill(255,128,128);
  else fill(128,128,128);
  text("SAW",218,75);  
  line(148,100,248,100);
  line(182,100,182,80);
  line(215,100,215,80); 
  if(waveform_A==3) fill(255,128,128);
  else fill(128,128,128);
  text("RCT",153,95);
  if(waveform_A==4) fill(255,128,128);
  else fill(128,128,128);
  text("SQU",186,95);
  if(waveform_A==5) fill(255,128,128);
  else fill(128,128,128);
  text("DIS",223,95);  
  
  // Waveform B Selection
  fill(128,255,128);  
  line(148,208,248,208);
  line(182,188,182,208);
  line(215,188,215,208);
  if(waveform_B==0) fill(128,255,128);
  else fill(128,128,128);
  text("SIN",156,75+128);
  if(waveform_B==1) fill(128,255,128);
  else fill(128,128,128);
  text("TRI",189,75+128);
  if(waveform_B==2) fill(128,255,128);
  else fill(128,128,128);
  text("SAW",218,75+128); 
  line(148,228,248,228);
  line(182,228,182,208);
  line(215,228,215,208); 
  if(waveform_B==3) fill(128,1255,128);
  else fill(128,128,128);
  text("RCT",153,95+128);
  if(waveform_B==4) fill(128,255,128);
  else fill(128,128,128);
  text("SQU",186,95+128);
  if(waveform_B==5) fill(128,255,128);
  else fill(128,128,128);
  text("DIS",223,95+128);  
}
