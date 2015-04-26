class WaveformRenderer implements AudioListener
{
  //  private float[] left;
  //  private float[] right;

  WaveformRenderer()
  {
    //    left = null; 
    //    right = null;
  }

  synchronized void samples(float[] samp)
  {
    monostereo=false;
    int j=2;
    //    left = samp;
    if (!stopped) {
      while (J<A_Buffer) {    
        if (trigged==false) {
          int i=0;
          while ( (i<A_Buffer)&&(samp[i]<triglevel) ) i++;
          if ( (i<A_Buffer)&&(i>0)&&(samp[i-1]<samp[i]) ) {
            trigged = true; 
            J = i;
          } else J=A_Buffer;
        } else {  
          if (display!=1) {
            display11[int(I)]=samp[int(J)];
            I++;
            J=J+tbase;
            if (I>=W_Width) {
              I=0; 
              display=1; 
              trigged=false;
              J=A_Buffer; 
              if (once) stopped=true;
              freqval1 = false;           
              while ( (j<512)&&(!((display11[j-1]<triglevel)&&(display11[j]>triglevel)))) j++;
              if (j<512) freq1 = 40000/(j*tbase_list[i_tbase]); 
              else freq1=0;
            }
          } else {
            display12[int(I)]=samp[int(J)];
            I++;
            J=J+tbase;
            if (I>=W_Width) {
              I=0; 
              display=0; 
              trigged=false;
              J=A_Buffer; 
              if (once) stopped=true;
            }
          }
        }
      }
      J=J-A_Buffer;
    }
  }

  synchronized void samples(float[] sampL, float[] sampR)
  {
    monostereo=true;
    //    left = sampL;
    //    right = sampR;
    int j=2;
    if (!stopped) {
      while (J<A_Buffer) {    
        if (trigged==false) {
          int i=0;
          if (trigin==false) {
            while ( (i<A_Buffer)&&(sampL[i]<triglevel) ) i++;
            if ( (i<A_Buffer)&&(i>0)&&(sampL[i-1]<sampL[i]) ) {
              trigged = true; 
              J = i;
            } else J=A_Buffer;
          } else {
            while ( (i<A_Buffer)&&(sampR[i]<triglevel) ) i++;
            if ( (i<A_Buffer)&&(i>0)&&(sampR[i-1]<sampL[i]) ) {
              trigged = true; 
              J = i;
            } else J=A_Buffer;
          }
        } else {  
          if (display!=1) {
            display11[int(I)]=sampL[int(J)];
            display21[int(I)]=sampR[int(J)];
            I++;
            J=J+tbase;
            if (I>=W_Width) {
              I=0; 
              display=1; 
              trigged=false;
              J=A_Buffer; 
              if (once) stopped=true;
              
              // Alignment
              if (alignment) {
                float minlvl1=10;
                float maxlvl1=-10;
                float minlvl2=10;
                float maxlvl2=-10;                
                for (j=0;j<512;j++) {
                  if (minlvl1>display11[j]) minlvl1=display11[j];
                  if (maxlvl1<display11[j]) maxlvl1=display11[j];
                  if (minlvl2>display21[j]) minlvl2=display21[j];
                  if (maxlvl2<display21[j]) maxlvl2=display21[j];
                }
                vp1=linelevel1/(maxlvl1-minlvl1);
                vp2=linelevel2/(maxlvl2-minlvl2);
                alignment=false;
              }
              
              // Frequency Measurement
              freqval1 = false;
              freqval2 = false;    
              j=2;       
              while ( (j<512)&&(!((display11[j-1]<triglevel)&&(display11[j]>triglevel)))) j++;
              if (j<512) freq1 = 40000/(j*tbase_list[i_tbase]); 
              else freq1=0;
              j=2;
              while ( (j<512)&&(!((display21[j-1]<triglevel)&&(display21[j]>triglevel)))) j++;
              if (j<512) freq2 = 40000/(j*tbase_list[i_tbase]); 
              else freq2=0;
            }
          } else {
            display12[int(I)]=sampL[int(J)];
            display22[int(I)]=sampR[int(J)];
            I++;
            J=J+tbase;
            if (I>=W_Width) {
              I=0; 
              display=0; 
              trigged=false;
              J=A_Buffer; 
              if (once) stopped=true;
            }
          }
        }
      }
      J=J-A_Buffer;
    }
  }
}

void stop()
{
  // always close Minim audio classes when you finish with them
  in.close();
  minim.stop();
  super.stop();
}

