i2mtc-2020



# Effect of the Exposure Time in Laser Speckle Imaging for Improving Blood Vessels Localization: a Wavelet Approach 

This repository has the functions to implement the methods described in the conference article: 
[*"Effect of the Exposure Time in Laser Speckle Imaging for Improving Blood Vessels Localization: a Wavelet Approach"*](https://ieeexplore.ieee.org/abstract/document/9129242), developed as part of the project *"Visualization and localization of blood vessels"* at [INAOE](https://www.inaoep.mx). 

## Abstract

The visualization and localization of blood vessels in Laser Speckle Contrast Imaging is an important task to determine the presence of blood vessels in the biological tissue. However, Laser Speckle Contrast Imaging has some drawbacks when the depth of the blood vessels increases. This work establishes a methodology based on a wavelet approach to improve the localization of blood vessels in *in-vitro* contrast images. It also determines a useful exposure time to improve the localization of blood vessels. The results show that the wavelet approach allows blood vessels to be located up to 510µm deep under a skin phantom. In addition, it states that high exposure times increase the percentage of similarity in traditional models and visualization enhancement models.



## Contents

* `i2mtc2020.pdf` and `keynote-i2mtc2020.pdf` - PDF files. Conference article and keynote *"Effect of the Exposure Time in Laser Speckle Imaging for Improving Blood Vessels Localization: a Wavelet Approach".* 


* `f_i2mtc2020.m` -  Matlab script. The script  `f_i2mtc2020.m` contains 1 main function (`f_i2mtc2020`) and four auxiliary functions ( `f_skavg`, `f_denoising`, `f_clustering`, `f_randindex`) to implement the methods described in the conference paper (`i2mtc2020.pdf`). 

* `data.mat` - MAT file. It contains a cell with two fields. 
  * Field 1 contains a package of 30 *in-vitro* speckle images of a straight vessel at a depth of 0µm. The image is a 445x461x30 grayscale matrix.
  * Field 2 contains the ground truth of the *in-vitro* speckle image of a straight vessel. The image is a 445x461 pixel logical type matrix. 


* `main.mlx` - Matlab live script. It contains an example of the image processing available in `'data.mat'`. This live script describes step by step the use of the auxiliary functions described in `f_i2mtc2020.m` 


## Organization

No additional content directories are declared. 


## Contributors

Code for algorithms, applications and tools contributed by:

F. Lopez-Tiro, H. Peregrina-Barreto, J. Rangel-Magdaleno, J. C. Ramirez-San-Juan and J. M. Ramirez-Cortes

Please email us your comments, criticism, and questions at `francisco.lopez@inaoe.mx`


## Reference

If you use functions from this script in your work, please use the BibTex entry below for citation.

[[IEEE's paper]](https://ieeexplore.ieee.org/abstract/document/9129242)

```
@INPROCEEDINGS{9129242,
  author={F. {Lopez-Tiro} and H. {Peregrina-Barreto} and J. {Rangel-Magdaleno} and J. C. {Ramirez-San-Juan} and J. M. {Ramirez-Cortes}},
  booktitle={2020 IEEE International Instrumentation and Measurement Technology Conference (I2MTC)}, 
  title={Effect of the Exposure Time in Laser Speckle Imaging for Improving Blood Vessels Localization: a Wavelet Approach}, 
  year={2020},
  volume={},
  number={},
  pages={1-6},
  doi={10.1109/I2MTC43012.2020.9129242}}
```
