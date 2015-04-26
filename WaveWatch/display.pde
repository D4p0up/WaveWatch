void draw()
{

  background(0);
  strokeWeight(1);

  if (dfade>0) dfade=dfade-1;

  tint(255, 48+dfade);
  image(splash, 0, 0);


  //trigger
  stroke(0, 128, 128);
  strokeWeight(4);
  line(1, 1, I, 1);

  // GRID
  stroke(50, 50, 50);
  strokeWeight(1);
  for (int i=1; i<7; i++) {
    stroke(50, 50, 50);
    line(W_Width/2+40*i, 0, W_Width/2+40*i, W_Height);
    line(0, W_Height/2+40*i, W_Width, W_Height/2+40*i);
    line(W_Width/2-40*i, 0, W_Width/2-40*i, W_Height);
    line(0, W_Height/2-40*i, W_Width, W_Height/2-40*i);
    stroke(108, 222, 195);
    line(W_Width/2+40*i, W_Height/2-4, W_Width/2+40*i, W_Height/2+4);
    line(W_Width/2-40*i, W_Height/2-4, W_Width/2-40*i, W_Height/2+4);
    line(W_Width/2-4, W_Height/2+40*i, W_Width/2+4, W_Height/2+40*i);    
    line(W_Width/2-4, W_Height/2-40*i, W_Width/2+4, W_Height/2-40*i);
  }

  // Channel 0V line
  if (Ldisplay) {
    stroke(84, 0, 0);
    line(0, offset1, 512, offset1);
  }
  if (Rdisplay) {
    stroke(0, 84, 0);
    line(0, offset2, 512, offset2);
  }

  // Référentiel
  stroke(108, 222, 195);
  line(W_Width/2, 0, W_Width/2, W_Height);
  line(0, W_Height/2, W_Width, W_Height/2);

  // Left Channel
  if (Ldisplay) {
    stroke(255, 128, 128);
    strokeJoin(ROUND);
    strokeWeight(2);
    if (display==1) {
      for (int i = 1; i < 511; i++)
      {
        line(i, offset1 - display11[i-1]*gain1, i+1, offset1 - display11[i]*gain1);
      }
    } else {
      for (int i = 1; i < 511; i++)
      {
        line(i, offset1 - display12[i-1]*gain1, i+1, offset1 - display12[i]*gain1);
      }
    }
  }

  // Right Channel
  if (Rdisplay) {  

    stroke(128, 255, 128);
    strokeJoin(ROUND);
    strokeWeight(2);
    if (display==1) {
      for (int i = 1; i < 511; i++)
      {
        line(i, offset2 - display21[i-1]*gain2, i+1, offset2 - display21[i]*gain2);
      }
    } else {
      for (int i = 1; i < 511; i++)
      {
        line(i, offset2 - display22[i-1]*gain2, i+1, offset2 - display22[i]*gain2);
      }
    }
  }

  // Origin
  strokeWeight(1);
  strokeJoin(ROUND);
  if (Ldisplay) {
  stroke(255, 0, 0);
  line(0, offset1-5, 5, offset1);
  line(0, offset1+5, 5, offset1);
  }
  if (Rdisplay) {
  stroke(0, 255, 0);
  line(512, offset2-5, 507, offset2);
  line(512, offset2+5, 507, offset2);
  }
  


  // Trigger level
  if (trigin==false) {
    stroke(255, 0, 0);
    line(0, offset1-gain1*triglevel, 10, offset1-gain1*triglevel);
  } else {
    stroke(0, 255, 0);
    line(0, offset2-gain2*triglevel, 10, offset2-gain2*triglevel);
  }
    fill(0,0,0);
    if (Ldisplay) {
      stroke(255, 128, 128);
    } else stroke(96, 96, 96);
    rect(257, 2, 39, 19);
    if (Rdisplay) {
      stroke(128, 255, 128);
    } else  stroke(96, 96, 96);
   rect(297, 2, 39, 19); 
    fill(255, 128, 128);
    text("ChA", 262, 16);
    fill(128, 255, 128);
    text("ChB", 302, 16);

  // Timebase and mode 
  fill(255, 255, 255);
  text("T:"+tbase_list[i_tbase]+"ms", 342, 16);
  if (stopped) {
    stroke(255, 128, 128);
    fill(255, 128, 128);
    strokeJoin(ROUND);
    strokeWeight(1);
    rect(490, 5, 15, 15, 7);
    text("Stopped",430,16);
  } else {
    if (trigged|!once) {
      stroke(128, 255, 128);
      fill(128, 255, 128);
      strokeJoin(ROUND);
      strokeWeight(1);
      rect(490, 5, 15, 15, 7);
      text("Running",430,16);
    } else {
      stroke(128, 128, 255);
      fill(128, 128, 255);
      strokeJoin(ROUND);
      strokeWeight(1);
      rect(490, 5, 15, 15, 7);
      text("Ready",430,16);
    }
  }
   

  // Channel Data
  if (Ldisplay) {
    fill(255, 128, 128);
    text("V:"+vp1*40/gain1+"V", 22, 475);
    if (!trigin) text("F:"+round(freq1)+"Hz", 142, 475);
  }
  if (Rdisplay) {
    fill(128, 255, 128);
    text("V:"+vp2*40/gain2+"V", 262, 475);
    if (trigin) text("F:"+round(freq2)+"Hz", 382, 475);
  }
  
    stroke(255, 255, 255);
  // Cursors
  switch (mesure) {
  case 0:
    break;

  case 1:
    // Display Measurement cursor
    line(mouseX, 0, mouseX, W_Height);
    line(0, mouseY, W_Width, mouseY);
    break;

  case 2:
    // Display Measurement cursor
    line(mouseX, 0, mouseX, W_Height);
    line(0, mouseY, W_Width, mouseY);
    // Display Cursor 1
    //line(m1X, 0, m1X, W_Height);
    //line(0, m1Y, W_Width, m1Y);
    line(m1X, m1Y, m1X+10, m1Y);
    line(m1X, m1Y, m1X-10, m1Y);    
    line(m1X, m1Y, m1X, m1Y+10);
    line(m1X, m1Y, m1X, m1Y-10);
    break;

  case 3:
    // Display Cursor 1
    line(m1X, m1Y, m1X+10, m1Y);
    line(m1X, m1Y, m1X-10, m1Y);    
    line(m1X, m1Y, m1X, m1Y+10);
    line(m1X, m1Y, m1X, m1Y-10);    
    // Display Cursor 2
    line(m2X, m2Y, m2X+10, m2Y);
    line(m2X, m2Y, m2X-10, m2Y);    
    line(m2X, m2Y, m2X, m2Y+10);
    line(m2X, m2Y, m2X, m2Y-10);   
    fill(255, 255, 255);
    text("dT:"+(m2X-m1X)*tbase_list[i_tbase]/40+"ms", 382, 440);
    text("dV:"+(m2Y-m1Y)/gain1*vp1+"V", 382, 450);
    break;
  }
  
  // Bottom UI
  strokeWeight(1);
  fill(0, 0, 0);
   if (trigin==false) {
    stroke(255, 128, 128);
    rect(16,481,39,19);
    fill(255, 128, 128);
    text("TrigA",20,495);
  } else {
    stroke(128, 255, 128);
    rect(16,481,39,19);
    fill(128, 255, 128);
    text("TrigB",20,495);
  }
  
  fill(0, 0, 0);
  stroke(255, 128, 128);
  rect(56,481,79,19);
  fill(255, 128, 128);
  text("Gain",82,495);
  text("+",65,495);
  text("-",115,495);
  
  fill(0, 0, 0);
  stroke(128, 255, 128);
  rect(136,481,79,19);
  fill(128, 255, 128);
  text("Gain",162,495);
  text("+",145,495);
  text("-",195,495);
  
  fill(0, 0, 0);
  stroke(168, 168, 168);
  rect(216,481,79,19);
  fill(168, 168, 168);
  text("Time",242,495);
  text("+",225,495);
  text("-",277,495);
  
  fill(0,0,0);
  stroke(168, 168, 168);
  rect(296,481,39,19);
  fill(168, 168, 168);
  if (once) {
    fill(168, 168, 200);
    text("Single", 300, 495);
  } 
  else {
    fill(168, 200, 168);
    text("Auto", 303, 495);
  }
  
  fill(0,0,0);
  stroke(168, 168, 168);
  rect(336,481,39,19);
  if (stopped) {
    fill(168, 255, 168);
    text("Start", 343, 495);
  } 
  else {
    fill(255, 168, 168);
    text("Stop", 344, 495);
  }
  
  fill(0, 0, 0);
  stroke(168, 168, 168);
  rect(376,481,79,19);
  fill(168, 168, 168);
  text("Trig",402,495);
  text("+",385,495);
  text("-",437,495);
  
  if (mesure!=0) {
    fill(255,255,255);
    stroke(168, 168, 200);
    rect(456,481,39,19);
    fill(0, 0, 0);
    text("Meas", 460, 495);
  } 
  else {
    fill(0, 0, 0);
    rect(456,481,39,19);
    fill(168, 200, 168);
    text("Meas", 460, 495);
  }
  fill(168, 168, 0);
  text("?",503,495);
  text("i",5,495);
  
}

