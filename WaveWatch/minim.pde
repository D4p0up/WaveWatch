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
    samples(samp, samp);
  }

  synchronized void samples(float[] sampL, float[] sampR)
  {
    monostereo=true;
    // Buffer content explorating 
    if (!stopped) { // if Scope is running...
      while (J<A_Buffer) { // ...and buffer contains sample to look at according to display sample rate
        l_buffer[int(K)]=sampL[int(J)];
        r_buffer[int(K)]=sampR[int(J)];        
        K=K+1;
        if (K>=D_Buffer) K=0;
        J=J+tbase;
        // 2/4 de buffer
        if (K==1536) {
          if (started==0) {
            int i=512;
            boolean found=false;
            while ( (i<1023)&&(found==false)) { 
              if (trig_dir) { 
                if ((l_buffer[i]<triglevel)&&(l_buffer[i+1]>=triglevel)&&(!trigin)) found=true;
                if ((r_buffer[i]<triglevel)&&(r_buffer[i+1]>=triglevel)&&(trigin)) found=true;
              }
              if (!trig_dir) { 
                if ((l_buffer[i]>triglevel)&&(l_buffer[i+1]<=triglevel)&&(!trigin)) found=true;
                if ((r_buffer[i]>triglevel)&&(r_buffer[i+1]<=triglevel)&&(trigin)) found=true;
              }               
              i=i+1;
            }
            if (found) {
              for (int j=0; j<512; j=j+1) {
                display11[j]=l_buffer[i+j-trigdelta];
                display21[j]=r_buffer[i+j-trigdelta];
              }
              if (once) stopped=true;
            }
            // Alignment
            if (alignment) {
              float minlvl1=10;
              float maxlvl1=-10;
              float minlvl2=10;
              float maxlvl2=-10;                
              for (int j=0; j<512; j++) {
                if (minlvl1>display11[j]) minlvl1=display11[j];
                if (maxlvl1<display11[j]) maxlvl1=display11[j];
                if (minlvl2>display21[j]) minlvl2=display21[j];
                if (maxlvl2<display21[j]) maxlvl2=display21[j];
              }
              vp1=linelevel1/(maxlvl1-minlvl1);
              vp2=linelevel2/(maxlvl2-minlvl2);
              alignment=false;
              output = createWriter("voltage.tsv");
              output.println("ChA"+TAB+linelevel1+"\t");
              output.println("ChB"+TAB+linelevel2+"\t");
              output.println("vp1"+TAB+vp1+"\t");
              output.println("vp1"+TAB+vp2+"\t");
              output.flush(); // Write the remaining data
              output.close(); // Finish the file
              dfade=100;
            }
            // Frequency Measurement
            //              freqval1 = false;
            //              freqval2 = false;    
            int j=(trigdelta+2)%512;       
            while ( (j<512)&&(!((display11[j-1]<=triglevel)&&(display11[j]>triglevel)))) j++;
            if (j<512) freq1 = 40000/((j-trigdelta)*tbase_list[i_tbase]); 
            else freq1=0;
            j=(trigdelta+2)%512;
            while ( (j<512)&&(!((display21[j-1]<=triglevel)&&(display21[j]>triglevel)))) j++;
            if (j<512) freq2 = 40000/((j-trigdelta)*tbase_list[i_tbase]); 
            else freq2=0;
          } else started=started-1;
        }
        // 3/4 de buffer
        if (K==0) {
          if (started==0) {
            int i=1024;
            boolean found=false;
            while ( (i<1535)&&(found==false)) {
              if (trig_dir) { 
                if ((l_buffer[i]<triglevel)&&(l_buffer[i+1]>=triglevel)&&(!trigin)) found=true;
                if ((r_buffer[i]<triglevel)&&(r_buffer[i+1]>=triglevel)&&(trigin)) found=true;
              }
              if (!trig_dir) { 
                if ((l_buffer[i]>triglevel)&&(l_buffer[i+1]<=triglevel)&&(!trigin)) found=true;
                if ((r_buffer[i]>triglevel)&&(r_buffer[i+1]<=triglevel)&&(trigin)) found=true;
              }               
              i=i+1;            }
            if (found) {
              for (int j=0; j<512; j=j+1) {
                display11[j]=l_buffer[i+j-trigdelta];
                display21[j]=r_buffer[i+j-trigdelta];
              }
              if (once) stopped=true;
            }
          } else started=started-1;
        }       
        // 4/4 de buffer
        if (K==512) {
          if (started==0) {
            int i=1535;
            boolean found=false;
            while ( (i<2047)&&(found==false)) {
              if (trig_dir) { 
                if ((l_buffer[i]<triglevel)&&(l_buffer[i+1]>=triglevel)&&(!trigin)) found=true;
                if ((r_buffer[i]<triglevel)&&(r_buffer[i+1]>=triglevel)&&(trigin)) found=true;
              }
              if (!trig_dir) { 
                if ((l_buffer[i]>triglevel)&&(l_buffer[i+1]<=triglevel)&&(!trigin)) found=true;
                if ((r_buffer[i]>triglevel)&&(r_buffer[i+1]<=triglevel)&&(trigin)) found=true;
              }               
              i=i+1;            }
            if (found) {
              for (int j=0; j<512; j=j+1) {
                display11[j]=l_buffer[(i+j-trigdelta)%2048];
                display21[j]=r_buffer[(i+j-trigdelta)%2048];
              }
              if (once) stopped=true;
            }
          } else started=started-1;
        }    
        // 1/4 de buffer
        if (K==1024) {
          if (started==0) {
            int i=0;
            boolean found=false;
            while ( (i<511)&&(found==false)) {
              if (trig_dir) { 
                if ((l_buffer[i]<triglevel)&&(l_buffer[i+1]>=triglevel)&&(!trigin)) found=true;
                if ((r_buffer[i]<triglevel)&&(r_buffer[i+1]>=triglevel)&&(trigin)) found=true;
              }
              if (!trig_dir) { 
                if ((l_buffer[i]>triglevel)&&(l_buffer[i+1]<=triglevel)&&(!trigin)) found=true;
                if ((r_buffer[i]>triglevel)&&(r_buffer[i+1]<=triglevel)&&(trigin)) found=true;
              }               
              i=i+1;            }
            if (found) {
              for (int j=0; j<512; j=j+1) {
                display11[j]=l_buffer[(i+j-trigdelta+2048)%2048];
                display21[j]=r_buffer[(i+j-trigdelta+2048)%2048];
              }
              if (once) stopped=true;
            }
          } else started=started-1;
        }          
//=======================================
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

