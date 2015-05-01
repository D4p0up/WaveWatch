class WaveformRenderer implements AudioSignal
{

  WaveformRenderer()
  {

  }
  
  synchronized void generate(float[] samp)
  {
    generate(samp,samp);
  }
  
  synchronized void generate(float[] sampL,float[] sampR)
  {
    for (int i=0; i<512; i=i+1) {
     if (wA_on) sampL[i]=-amp_A*wave_A[int(phase_acc_A)]; else sampL[i]=0;
     phase_acc_A=(phase_acc_A+delta_acc_A)%2048;
    }
    for (int i=0; i<512; i=i+1) {
     if (wB_on) sampR[i]=-amp_B*wave_B[int(phase_acc_B)]; else sampR[i]=0;
     phase_acc_B=(phase_acc_B+delta_acc_B)%2048;
    }
  }
}
