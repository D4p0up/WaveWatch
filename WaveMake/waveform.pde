/*
===================================================
  _      __              __  ___     __      
 | | /| / /__ __  _____ /  |/  /__ _/ /_____ 
 | |/ |/ / _ `/ |/ / -_) /|_/ / _ `/  '_/ -_)
 |__/|__/\_,_/|___/\__/_/  /_/\_,_/_/\_\\__/ 

 Open Source Soundcard Waveform generator by Banson                                             
 Background image by Humusak
 V1.0
                                                 
 http://www.banson.fr/wiki/doku.php?id=wavewatch

 =================================================
 Provided under the following license: by-nc-sa
 http://creativecommons.org/licenses/by-nc-sa/4.0/
 =================================================
 
 */
 
void setSin(float[] buffer) {
  for (int i=0; i<2048; i=i+1) {
    buffer[i]=sin(2*3.1415927*i/2048);
  }
}

void setTri(float[] buffer) {
  int j=0;
  for (int i=0; i<512; i=i+1) {
    buffer[i]=float(i)/512;
    j=j+1;
  }
  for (int i=0; i<1024; i=i+1) {
    buffer[j]=(512-float(i))/512;
    j=j+1;
  }
  for (int i=0; i<512; i=i+1) {
    buffer[j]=-(512-float(i))/512;
    j=j+1;
  }
}

void setSaw(float[] buffer) {
  for (int i=0; i<2048; i=i+1)
    buffer[i]=float(i)/1024-1;
}

void setSqu(float[] buffer) {
  for (int i=0; i<2048; i=i+1){
    if (i>1024) buffer[i]=-1; else buffer[i]=1;
  }
}

void setDis(float[] buffer) {
  for (int i=0; i<2048; i=i+1){
    buffer[i]=2.3*(1/(1+float(i)/400))-1.3;
  }
}

void setRct(float[] buffer) {
  for (int i=0; i<2048; i=i+1) {
    buffer[i]=2*sin(2*3.1415927*i/4096)-1;
  }
}
