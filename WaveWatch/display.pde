void draw()
{

  background(0);
  strokeWeight(1);

  if (dfade>0) dfade=dfade-1;

  tint(255, 32+dfade);
  image(splash, 0, 0);


  //trigger
  stroke(0, 128, 128);
  strokeWeight(4);
  line(1, 1, K%1024, 1);

  // GRID
  stroke(16, 16, 16);
  strokeWeight(1);
  for (int i=1; i<13; i++) {
    stroke(32, 32, 32);
    line(W_Width/2+40*i, 0, W_Width/2+40*i, W_Height);
    line(0, W_Height/2+40*i, W_Width, W_Height/2+40*i);
    line(W_Width/2-40*i, 0, W_Width/2-40*i, W_Height);
    line(0, W_Height/2-40*i, W_Width, W_Height/2-40*i);
    stroke(98, 202, 165);
    line(W_Width/2+40*i, W_Height/2-4, W_Width/2+40*i, W_Height/2+4);
    line(W_Width/2-40*i, W_Height/2-4, W_Width/2-40*i, W_Height/2+4);
    line(W_Width/2-4, W_Height/2+40*i, W_Width/2+4, W_Height/2+40*i);    
    line(W_Width/2-4, W_Height/2-40*i, W_Width/2+4, W_Height/2-40*i);
  }

  // Channel 0V line
  if (Ldisplay) {
    stroke(84, 0, 0);
    line(0, offset1, 1024, offset1);
  }
  if (Rdisplay) {
    stroke(0, 84, 0);
    line(0, offset2, 1024, offset2);
  }

  // Référentiel
  stroke(108, 170, 195);
  line(W_Width/2, 0, W_Width/2, W_Height);
  line(0, W_Height/2, W_Width, W_Height/2);

  // Left Channel
  if (Ldisplay) {
    stroke(255, 128, 128);
    strokeJoin(ROUND);
    strokeWeight(2);
    for (int i = 1; i < 1023; i++)
    {
      line(i, offset1 - display11[i-1]*gain1, i+1, offset1 - display11[i]*gain1);
    }
  }

  // Right Channel
  if (Rdisplay) {  

    stroke(128, 255, 128);
    strokeJoin(ROUND);
    strokeWeight(2);

    for (int i = 1; i < 1023; i++)
    {
      line(i, offset2 - display21[i-1]*gain2, i+1, offset2 - display21[i]*gain2);
    }
  }


  // Origin
  strokeWeight(2);
  strokeJoin(ROUND);
  if (Ldisplay) {
    stroke(255, 0, 0);
    line(0, offset1-5, 5, offset1);
    line(0, offset1+5, 5, offset1);
  }
  if (Rdisplay) {
    stroke(0, 255, 0);
    line(1024, offset2-5, 1019, offset2);
    line(1024, offset2+5, 1019, offset2);
  }

strokeWeight(1);
  // Trigger level
  if (trigin==false) {
    stroke(255, 0, 0);
    line(trigdelta-6, offset1-gain1*triglevel, trigdelta+6, offset1-gain1*triglevel);
    line(trigdelta, offset1-gain1*triglevel+6, trigdelta, offset1-gain1*triglevel-6);
  } else {
    stroke(0, 255, 0);
    line(trigdelta-6, offset2-gain2*triglevel, trigdelta+6, offset2-gain2*triglevel);
    line(trigdelta, offset2-gain2*triglevel+6, trigdelta, offset2-gain2*triglevel-6);
  }
  
  fill(0, 0, 0);
  strokeWeight(2);
  // Channel Name and Activity
  if (Ldisplay) {
    stroke(255, 128, 128);
  } else stroke(96, 96, 96);
  rect(32, 481, 39, 19);
  if (Rdisplay) {
    stroke(128, 255, 128);
  } else  stroke(96, 96, 96);
  rect(192, 481, 39, 19); 
  fill(255, 128, 128);
  text("ChA", 38, 495);
  fill(128, 255, 128);
  text("ChB", 198, 495);

  // Timebase display
  fill(0);
  stroke(128, 128, 128);
  rect(472, 481, 79, 19);
  fill(200);
  text("T:"+tbase_list[i_tbase]+"ms", 482, 495);


  // Mode display
  if (stopped) {
    stroke(255, 128, 128);
    fill(255, 128, 128);
    rect(1002, 5, 15, 15, 7);
    text("Stopped", 942, 16);
  } else {
    if (!once|trigged) {
      stroke(128, 255, 128);
      fill(128, 255, 128);
      rect(1002, 5, 15, 15, 7);
      text("Running", 942, 16);
    } else {
      stroke(128, 128, 255);
      fill(128, 128, 255);
      rect(1002, 5, 15, 15, 7);
      text("Ready", 942, 16);
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
    strokeWeight(1);
    line(mouseX, 0, mouseX, W_Height);
    line(0, mouseY, W_Width, mouseY);
    break;

  case 2:
    // Display Measurement cursor
    strokeWeight(1);
    line(mouseX, 0, mouseX, W_Height);
    line(0, mouseY, W_Width, mouseY);
    // Display Cursor 1
    strokeWeight(2);
    line(m1X, m1Y, m1X+5, m1Y);
    line(m1X, m1Y, m1X-5, m1Y);    
    line(m1X, m1Y, m1X, m1Y+5);
    line(m1X, m1Y, m1X, m1Y-5);
    fill(220, 220, 220);
    text("dT:"+(mouseX-m1X)*tbase_list[i_tbase]/40+"ms", mouseX+20, mouseY+20);
    text("dV:"+(mouseY-m1Y)/gain1*vp1+"V", mouseX+20, mouseY+32);    
    break;

  case 3:
    // Display Cursor 1
    strokeWeight(2);
    line(m1X, m1Y, m1X+5, m1Y);
    line(m1X, m1Y, m1X-5, m1Y);    
    line(m1X, m1Y, m1X, m1Y+5);
    line(m1X, m1Y, m1X, m1Y-5);    
    // Display Cursor 2
    strokeWeight(2);
    line(m2X, m2Y, m2X+5, m2Y);
    line(m2X, m2Y, m2X-5, m2Y);    
    line(m2X, m2Y, m2X, m2Y+5);
    line(m2X, m2Y, m2X, m2Y-5);   
    fill(220, 220, 220);
    text("dT:"+(m2X-m1X)*tbase_list[i_tbase]/40+"ms", mouseX+20, mouseY+20);
    text("F:"+abs(round(1000/((m2X-m1X)*tbase_list[i_tbase]/40)))+"Hz", mouseX+20, mouseY+44);
    text("dV:"+(m2Y-m1Y)/gain1*vp1+"V", mouseX+20, mouseY+32);
    break;
  }

  // Bottom UI
  fill(0, 0, 0);
  if (trigin==false) {
    stroke(255, 128, 128);
    rect(632, 481, 39, 19);
    fill(255, 128, 128);
    text("TrigA", 636, 495);
  } else {
    stroke(128, 255, 128);
    rect(632, 481, 39, 19);
    fill(128, 255, 128);
    text("TrigB", 636, 495);
  }

  // Channel A Gain
  fill(0, 0, 0);
  stroke(255, 128, 128);
  rect(72, 481, 79, 19);
  fill(255, 128, 128);
  text("Gain", 98, 495);
  text("+", 81, 495);
  text("-", 132, 495);

  //Channel B Gain
  fill(0, 0, 0);
  stroke(128, 255, 128);
  rect(232, 481, 79, 19);
  fill(128, 255, 128);
  text("Gain", 258, 495);
  text("+", 241, 495);
  text("-", 292, 495);

  //Time base adjustment
  fill(0, 0, 0);
  stroke(168, 168, 168);
  rect(216+176, 481, 79, 19);
  fill(168, 168, 168);
  text("Time", 242+176, 495);
  text("+", 225+176, 495);
  text("-", 277+176, 495);

  //Mode display
  fill(0, 0, 0);
  stroke(168, 168, 168);
  rect(752, 481, 39, 19);
  fill(168, 168, 168);
  if (once) {
    fill(168, 168, 200);
    text("Single", 756, 495);
  } else {
    fill(168, 200, 168);
    text("Auto", 759, 495);
  }

  //Start & Stop
  fill(0, 0, 0);
  stroke(168, 168, 168);
  rect(792, 481, 39, 19);
  if (stopped) {
    fill(168, 255, 168);
    text("Start", 799, 495);
  } else {
    fill(255, 168, 168);
    text("Stop", 800, 495);
  }

  // Trigger display
  if (trig_en) fill(128, 128, 128);
  else fill(0, 0, 0);
  stroke(168, 168, 168);
  rect(672, 481, 79, 19);
  line(712, 481, 712, 500);
  if (trig_en) fill(0, 0, 0);
  else fill(168, 168, 168);
  text("Trig", 680, 495);

  // Rise Or Fall
  fill(0);
  stroke(255, 255, 255);
  if (trig_dir) {
    line(717, 495, 727, 495);
    line(727, 495, 737, 485);
    line(737, 485, 747, 485);
  } else {
    line(717, 485, 727, 485);
    line(727, 485, 737, 495);
    line(737, 495, 747, 495);
  }  

  if (mesure!=0) {
    fill(255, 255, 255);
    stroke(168, 168, 168);
    rect(912, 481, 79, 19);
    fill(0, 0, 0);
    text("Measure", 927, 495);
  } else {
    stroke(168, 168, 168);
    fill(0, 0, 0);
    rect(912, 481, 79, 19);
    fill(168, 200, 168);
    text("Measure", 927, 495);
  }
  fill(168, 168, 0);
  text("?", 1007, 495);
  text("i", 14, 495);
}