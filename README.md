# Plant Robot
<p align="center"><img src=https://user-images.githubusercontent.com/19663575/121645541-459ead00-cacf-11eb-8fe5-0f9bac5ff7fa.png width="400" height="400"></>

we present a new class of soft robotic plant animated by algorithmic choreography. Our main contributions include the following:
-	Designed the prototype of ‘audio-animatronic soft robotic plant’ and experimentally investigated its characteristic behavior.
-	Proposed an algorithmic choreography method to utilize active and passive motion of the soft robotic plant, and demonstrated its end-to-end application results. 
 
# Video
You can enjoy a plant robot that seems to move to music through this link.
 
Link : https://www.youtube.com/channel/UC6az8EEJUIKQF9WLKFskpDQ

## System configuration of the soft robotic plant
<p align="center"><img src=https://user-images.githubusercontent.com/19663575/121645009-ad082d00-cace-11eb-95b3-89ba55b41dc0.jpg width="600" height="300"></>        

The system input is the music song, and the outputs are the music sound, servo motors’ movement (eventually, the motion of the stems and leaves), and the light of the programmable LEDs. MC1 and MC2 mean memory card 1 and 2, respectively.

## Schematic diagrams of the algorithmic choreography process
<p align="center"><img src=https://user-images.githubusercontent.com/19663575/121646490-58fe4800-cad0-11eb-9743-a0b4731699a6.jpg width="800" height="500"></>        

The first group of blocks divides the music song into percussive and harmonic sound parts. The harmonic sound is what we perceive as a pitch sound and what makes us listen to melodies and chords. On the other hand, percussive sound comes from instrument onsets like the hit on a drum. HPSS analyzes the frequency characteristics of songs, and divides components in the Frequency domain through short time Fourier transform (STFT). Finally, we convert these components back to audio signal of time domain through Inverse short time Fourier transform (ISTFT).
The second group of blocks is the core part to determine the motion of the soft robotic plant. The classified percussive sound is the block input. Using the highest cross-correlation coefficient between the percussive sound part and each sound sample in the database, the algorithm selects the best-fitting sound sample of each instrument for the song. After that, the algorithm calculates and records their correlation coefficients over time. The cross-correlation coefficients over time are filtered again by clustering (n=2), and then only their local maximums and their time information are recorded in the form of a series of impulse with different magnitudes. These respectively mean the intensity of each drum sound and the played time.
In parallel with the above process, the algorithm makes the unit trajectory of each motor using the audio signal of the selected sound sample. In general, the frequency of audio signal in music songs is at least 50 Hz, so it is impossible for miniature motors to directly visualize them. The algorithm extracts only the signal amplitude (i.e., the absolute value), and then applies a low-pass-filer (moving average, 882 samples, window time period = 20 ms) to further soften the motion trajectory. The processed data is convoluted with the impulse data over time, which was obtained in the previous paragraph. The generated data is sampled again by the period of 20 ms considering the control loop speed of the motor system. Finally, the motion trajectory of the motor for the entire song is made. 
The third group of blocks classifies the pitches of the harmonic sounds by detecting chroma features, and then applied a binary mask to them. As a result, the second output of the algorithm has the sequential data about the main pitch classes at each time range. This data is visualized using LEDs installed in the circumferential direction at the top edge of the plant pot. 

## Result of plant robot movement
We analyzed in detail how the leaves move using the top-views.
<p align="center"><img src=https://user-images.githubusercontent.com/19663575/121647505-7253c400-cad1-11eb-89aa-3b4fefd888ce.jpg width="600" height="600"></> 
