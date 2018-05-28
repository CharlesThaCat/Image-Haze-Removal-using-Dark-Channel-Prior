# Image-Haze-Removal-using-Dark-Channel-Prior

Introduction
=
This is the Github page for Image Haze Romoval using Dark Channel Prior, which is the project of the course *Digital Image Processing (EE326)* in *Southern University of Science and Technology (SUSTech)*. <br>
The language we use is *MATLAB* with software in version *MATLAB 2017b*.

Project Timeline
=
2018/5/9
-
* Determine the topic of this project

2018/5/14
-
* Finish reading the first and second paper in "Relative Papers" section.

2018/5/18
-
* Finish the first version of the whole program, including:<br>
Dark channel computation<br>
Atmospheric light estimation<br>
Transmission estimation<br>
Guided filtering<br>

2018/5/23
-
* Finish reading the third paper in "Relative Papers" section.
* Improve the performances in "DarkChannel.m" and "AtmosphericLight.m".

2018/5/26
-
* Finish reading the fourth paper in in "Relative Papers" section.
* Improve the performance in "MinFilt.m" and VanHerkMin.m".
* Classify the files of this project into different documents.

2018/5/28
-
* Add "RMSE.m" and "main_score.m" to create a method to evaluate the quality of dehazing algorithm in different parameters or methods
* Add a new method to calculate atmospheric light A based on image entropy.

Relative Papers
=
* *Single Image Haze Removal Using Dark Channel Prior*, Kaiming He, Jian Sun, and Xiaoou Tang, Fellow, IEEE
* *Guided Image Filtering*, Kaiming He, Member, IEEE, Jian Sun, Member, IEEE, and Xiaoou Tang, Fellow, IEEE
* *A fast algorithm for local minimum and maximum filters on rectangular and octagonal kernels*, Marcel van Herk
* *A review on dark channel prior based image dehazing algorithms*, Sungmin Lee1, Seokmin Yun1, Ju-Hun Nam2, Chee Sun Won1 and Seung-Won Jung

Other Supporting Materials
=
* FRIDA (Foggy Road Image DAtabase)
* *An Adventure of Sorts–Behind the Scenes of a MATLAB Upgrade*, Bill McKeeman, MathWorks and Loren Shure, MathWorks
* About the image data type in MATLAB and their conversions: http://www.cnblogs.com/Allen-rg/p/6236009.html (website in Chinese)
