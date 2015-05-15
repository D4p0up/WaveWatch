void mouseDragged()
{
  if ((mouseX<20)&&(mouseY<450)) {
    offset1=mouseY;
  }
  if ((mouseX>1000)&&(mouseY<450)) {
    offset2=mouseY;
  }
  if (offset1<5) offset1=5;
  if (offset1>450) offset1=450;
  if (offset2<5) offset2=5;
  if (offset2>450) offset2=450;

  if ((mouseX>21)&&(mouseX<491)&&(mouseY>21)&&(mouseY<459)&&(mesure==0)&&trig_en) {
    if (!trigin) {
      triglevel=(float(mouseY)-offset1)*(-1)/gain1;
    } else {
      triglevel=(float(mouseY)-offset2)*(-1)/gain2;
    }
    trigdelta=mouseX;
  }
}

void mousePressed() 
{
  if ((mouseX<20)&&(mouseY<450)) {
    offset1=mouseY;
  }
  if ((mouseX>1000)&&(mouseY<450)) {
    offset2=mouseY;
  }    

  if (offset1<5) offset1=5;
  if (offset1>450) offset1=450;
  if (offset2<5) offset2=5;
  if (offset2>450) offset2=450;


  switch (mesure) {
  case 0:
    break;

  case 1:
    m1X=mouseX;
    m1Y=mouseY;
    mesure=2;
    break;

  case 2:
    m2X=mouseX;
    m2Y=mouseY;
    mesure=3;
    break;
  }


  if (mouseY>(W_Height)) {
    if ((mouseX>32)&&(mouseX<72)) {
      if (Ldisplay) Ldisplay=false; 
      else Ldisplay=true;
    }
    if ((mouseX>192)&&(mouseX<236)) {
      if (Rdisplay) Rdisplay=false; 
      else Rdisplay=true;
    }
    if ((mouseX>632)&&(mouseX<672)) {
      if (trigin==false) trigin=true; 
      else trigin=false;
    }
    if ((mouseX>72)&&(mouseX<112)) {
      gain1 = gain1 * 1.5; 
      if (gain1>10000)gain1=10000;
    }    
    if ((mouseX>112)&&(mouseX<152)) {
      gain1 = gain1 / 1.5; 
      if (gain1<1) gain1=1;
    }
    if ((mouseX>232)&&(mouseX<272)) {
      gain2 = gain2 * 1.5; 
      if (gain2>10000)gain2=10000;
    }       
    if ((mouseX>272)&&(mouseX<312)) {
      gain2 = gain2 / 1.5; 
      if (gain2<1) gain2=1;
    }   
    if ((mouseX>392)&&(mouseX<432)) {
      if (i_tbase<14) i_tbase=i_tbase+1;
      tbase = tbase_list[i_tbase]*44100/40000;
    }       
    if ((mouseX>432)&&(mouseX<476)) {
      if (i_tbase>0) i_tbase=i_tbase-1;
      tbase = tbase_list[i_tbase]*44100/40000;
    }
    if ((mouseX>752)&&(mouseX<792)) {
      if (once) {
        once=false; 
        stopped=false;
      } else {
        once=true; 
        stopped=true; 
        I=0; 
        J=0;
      }
    }     
    if ((mouseX>792)&&(mouseX<832)) {
      if (stopped) stopped = false;
      else {
        stopped = true;
        I=0;
        J=0;
      }
      started=2;
    }   
    if ((mouseX>672)&&(mouseX<712)) {
      if (trig_en) trig_en=false; 
      else trig_en=true;
    } 
    if ((mouseX>712)&&(mouseX<752)) {
      if (trig_dir) trig_dir=false; 
      else trig_dir=true;
    } 
    if ((mouseX>912)&&(mouseX<992)) {
      if (mesure!=0) mesure=0; 
      else mesure=1;
    } 
    if ((mouseX>1000)&&(mouseX<1024)) {
      showMessageDialog(null, "Keyboard Shortcuts :\n\r- 'u' and 'j' : Turn Left & Right Channel ON and OFF\n\r- 'e' and 'd' : Left Channel Gain\n\r- 'r' and 'f' : Right CHannel Gain\n\r- 'c' and 'v' : Time Base adjusting\n\r- mouse click on leftmost or rightmost window moves the origin\n\rAdvanced Controls :\n\r- 't' and 'g' : Trigger level adjustment\n\r- 'h' : Toggles triggering from channel A to channel B\n\r- 'b' : Activates measurement cursors\n\r- 'y' : Toggles between Auto and Single mode\n\r- 'k' : Aligns input voltage level\n\r- spacebar : Pause and Resume\n\rAnd of course :\n\r- 'o' : Exit Scope", 
      "Controls", INFORMATION_MESSAGE);
    }
    if ((mouseX>0)&&(mouseX<16)) {
      showMessageDialog(null, "WaveWatch version 1.3\n\rSoundcard Scope\n\rBy banson\n\rwww.banson.fr", 
      "Info", INFORMATION_MESSAGE);
    }
  } 

  // Trig
  if ((mouseX>21)&&(mouseX<1000)&&(mouseY>21)&&(mouseY<459)&&(mesure==0)&&trig_en) {
    if (!trigin) {
      triglevel=(float(mouseY)-offset1)*(-1)/gain1;
    } else {
      triglevel=(float(mouseY)-offset2)*(-1)/gain2;
    }
    trigdelta=mouseX;
  }
}


void keyPressed()
{
  switch(key) {
  case 'e': 
    gain1 = gain1 * 1.5; 
    if (gain1>10000)gain1=10000;
    break;
  case 'd': 
    gain1 = gain1 / 1.5; 
    if (gain1<1) gain1=1;
    break;
  case 'r': 
    gain2 = gain2 * 1.5; 
    if (gain2>10000)gain2=10000;
    break;
  case 'f': 
    gain2 = gain2 / 1.5; 
    if (gain2<1) gain2=1;
    break;
  case 'c': 
    if (i_tbase>0) i_tbase=i_tbase-1;
    tbase = tbase_list[i_tbase]*44100/40000;
    break;
  case 'v': 
    if (i_tbase<14) i_tbase=i_tbase+1;
    tbase = tbase_list[i_tbase]*44100/40000;
    break;
  case 'g': 
    triglevel =  triglevel-0.01;
    if (triglevel<-0.9) triglevel=-0.95; 
    break;
  case 't': 
    triglevel =  triglevel+0.01;
    if (triglevel>0.9) triglevel=0.95; 
    break;       
  case 'h':
    if (trigin==false) trigin=true; 
    else trigin=false;
    break;
  case ' ':
    if (stopped) stopped = false;
    else {
      stopped = true;
      I=0;
      J=0;
    }
    started=2;
    break;
  case 'y':
    if (once) {
      once=false; 
      stopped=false;
    } else {
      once=true; 
      stopped=true; 
      I=0; 
      J=0;
    }
    break;
  case 'b':
    if (mesure!=0) mesure=0; 
    else mesure=1;
    break;
  case 'k':
    alignment=true;
    break;
  case 'u':
    if (Ldisplay) Ldisplay=false; 
    else Ldisplay=true;
    break;
  case 'j':
    if (Rdisplay) Rdisplay=false; 
    else Rdisplay=true;
    break;
  case 'o':
    while (dfade<235) {
    exit();
    break;
    }
  }
}