void mousePressed() 
{
  // Channel activation
  if (mouseX<128) {
    if (mouseY<128) {
      if (wA_on) wA_on=false; 
      else wA_on=true;
    } else {
      if (wB_on) wB_on=false; 
      else wB_on=true;
    }
  }

  // Amplitude
  if ((mouseX>128)&&(mouseX<148)) {
    if (mouseY<128) {
      amp_A=(128-float(mouseY))/120;
    } else {
      amp_B=(256-float(mouseY))/120;
    }
    if (amp_A>1) amp_A=1;
    if (amp_A<0) amp_A=0;
    if (amp_B>1) amp_B=1;
    if (amp_B<0) amp_B=0;
  }
  //Fréquence
  if ((mouseX>248)&&(mouseX<268)) {
    if (mouseY<128) {
      if (ext_A==0) {
        freq_A=(128-mouseY)*2;
        if (freq_A>220) freq_A=220;
        if (freq_A<2) freq_A=2;
      }
      if (ext_A==1) {
        freq_A=(128-mouseY)*20;
        if (freq_A>2205) freq_A=2205;
        if (freq_A<20) freq_A=20;
      }
      if (ext_A==2) {
        freq_A=(128-mouseY)*200;
        if (freq_A>22050) freq_A=22050;
        if (freq_A<200) freq_A=200;
      }
      delta_acc_A=2048*(freq_A)/44100;
    }
    if (mouseY>128) {
      if (ext_B==0) {
        freq_B=(256-mouseY)*2;
        if (freq_B>220) freq_B=220;
        if (freq_B<2) freq_B=2;
      }      
      if (ext_B==1) {
        freq_B=(256-mouseY)*20;
        if (freq_B>2205) freq_B=2205;
        if (freq_B<20) freq_B=20;
      }
      if (ext_B==2) {
        freq_B=(256-mouseY)*200;
        if (freq_B>22050) freq_B=22050;
        if (freq_B<200) freq_B=200;
      }
      delta_acc_B=2048*(freq_B)/44100;
    }
  }

  // Freq Range A
  if ((mouseY>40)&&(mouseY<60)) {
    if ((mouseX>148)&&(mouseX<182)) ext_A=0;
    if ((mouseX>182)&&(mouseX<215)) ext_A=1;
    if ((mouseX>215)&&(mouseX<248)) ext_A=2;
  }

  // Waveform A
  if ((mouseY>60)&&(mouseY<80)) {
    if ((mouseX>148)&&(mouseX<182)) {
      waveform_A=0;
      setSin(wave_A);
    }
    if ((mouseX>182)&&(mouseX<215)) {
      waveform_A=1;
      setTri(wave_A);
    }
    if ((mouseX>215)&&(mouseX<248)) {
      waveform_A=2;
      setSaw(wave_A);
    }
  }
  if ((mouseY>80)&&(mouseY<100)) {
    if ((mouseX>148)&&(mouseX<182)) {
      waveform_A=3;
      setRct(wave_A);
    }
    if ((mouseX>182)&&(mouseX<215)) {
      waveform_A=4;
      setSqu(wave_A);
    }
    if ((mouseX>215)&&(mouseX<248)) {
      waveform_A=5;
      setDis(wave_A);
    }
  }  

  // Waveform B
  if ((mouseY>60+128)&&(mouseY<80+128)) {
    if ((mouseX>148)&&(mouseX<182)) {
      waveform_B=0;
      setSin(wave_B);
    }
    if ((mouseX>182)&&(mouseX<215)) {
      waveform_B=1;
      setTri(wave_B);
    }
    if ((mouseX>215)&&(mouseX<248)) {
      waveform_B=2;
      setSaw(wave_B);
    }
  }
  if ((mouseY>208)&&(mouseY<228)) {
    if ((mouseX>148)&&(mouseX<182)) {
      waveform_B=3;
      setRct(wave_B);
    }
    if ((mouseX>182)&&(mouseX<215)) {
      waveform_B=4;
      setSqu(wave_B);
    }
    if ((mouseX>215)&&(mouseX<248)) {
      waveform_B=5;
      setDis(wave_B);
    }
  }   

  // Freq Range B
  if ((mouseY>40+128)&&(mouseY<60+128)) {
    if ((mouseX>148)&&(mouseX<182)) ext_B=0;
    if ((mouseX>182)&&(mouseX<215)) ext_B=1;
    if ((mouseX>215)&&(mouseX<248)) ext_B=2;
  }
}

void mouseDragged() 
{
  if ((mouseX>128)&&(mouseX<148)) {
    if (mouseY<128) {
      amp_A=(128-float(mouseY))/120;
    } else {
      amp_B=(256-float(mouseY))/120;
    }
    if (amp_A>1) amp_A=1;
    if (amp_A<0) amp_A=0;
    if (amp_B>1) amp_B=1;
    if (amp_B<0) amp_B=0;
  }  

  //Fréquence
  if ((mouseX>248)&&(mouseX<268)) {
    if (mouseY<128) {
      if (ext_B==0) {
        freq_A=(256-mouseY)*2;
        if (freq_A>220) freq_A=220;
        if (freq_A<2) freq_A=2;
      }
      if (ext_A==0) {
        freq_A=(128-mouseY)*2;
        if (freq_A>220) freq_A=220;
        if (freq_A<2) freq_A=2;
      }
      if (ext_A==1) {
        freq_A=(128-mouseY)*20;
        if (freq_A>2205) freq_A=2205;
        if (freq_A<20) freq_A=20;
      }
      if (ext_A==2) {
        freq_A=(128-mouseY)*200;
        if (freq_A>22050) freq_A=22050;
        if (freq_A<200) freq_A=200;
      }
      delta_acc_A=2048*(freq_A)/44100;
    }
    if (mouseY>128) {
      if (ext_B==0) {
        freq_B=(256-mouseY)*2;
        if (freq_B>220) freq_B=220;
        if (freq_B<2) freq_B=2;
      }
      if (ext_B==1) {
        freq_B=(256-mouseY)*20;
        if (freq_B>2205) freq_B=2205;
        if (freq_B<20) freq_B=20;
      }
      if (ext_B==2) {
        freq_B=(256-mouseY)*200;
        if (freq_B>22050) freq_B=22050;
        if (freq_B<200) freq_B=200;
      }
      delta_acc_B=2048*(freq_B)/44100;
    }
  }
}

void keyPressed()
{
  switch(key) {
  case 'e':
    if (wA_on) wA_on=false; 
    else wA_on=true;
    break;  
  case 'd':
    if (wB_on) wB_on=false; 
    else wB_on=true;
    break;      
  case 'o':
    exit();
    break;
  }
}

