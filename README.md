# gnss2tws_slepian
GNSS2TWS_Slepian: A software to recover daily GNSS-inverted terrestrial water storage changes based on Slepian basis functions
# Attribution
This software is submitted in GPS Solutions. The primary purpose of this code is to achieve the recovery of daily large-scale terrestrial water storage (TWS) changes from GNSS-observed crustal vertical positions. Differing from the widely-used spatial-domain inversion strategy based on Green's function method, our inversion modeling is implemented in the spectral domain based on Slepian basis functions, which aims to infer daily large-scale TWS changes using sparsely distributed GNSS vertical data. We assume that the potential users are familiar with the Matlab language programming, PCA decomposition, inversion method, and mass loading theory. The code has been written in MATLAB (version 2018b and 2024a) and has been tested on Windows (version 11) operating systems.
Readers can download the complete software (including the code and one example (all input data)) from GitHub (https://github.com/jzshhh/gnss2tws_slepian) and we also release this open-source tool (including the code and one example (all input/output data)) on Zenodo (https://doi.org/10.5281/zenodo.11204223). There are no additional requirements except for the MATLAB language running environment and some basic toolboxes. In this public edition 1.0 of GNSS2TWS_Slepian, we provide an example to investigate the spatiotemporal TWS changes and to characterize hydrological extremes in the Western United States. Readers can directly run this example without additional operations.

# Some notes
1. Readers can directly run this example without additional operations through opening and runing the script "gnss2ewh_slepian_main.m". 
2. If your computer doesn’t have enough memory, please assign the variable "lmax" (in script "load_scenario.m") with smaller degrees.
3. It will take a long time to run our example for the first time and you can also make "lmax" smaller (e.g., 60) to test whether the program can run successfully on your computer. 
4. In the folder of "HATool",  two main functions ("plot_gnss_area_ewh_series_main.m" and "plot_gnss_drought_characterization_main.m") are used for conventional hydrological analysis after running your example.
5. If your MATLAB can achieve parallel computing, it will save a lot of time to calculate Slepian basis functions which are the most time-consuming.
7. This tool would call SLEPIAN Alpha (Harig et al., 2015; Harig and Simons 2012; Simons et al. 2006) to calculate Slepian basis functions, please also acknowledge them if you use it.
6. If you have any questions and suggestions, you can contact the first author (Name: Zhongshan Jiang E-mail: jiangzhsh@mail.sysu.edu.cn).

# To acknowledge use of this software, please cite the following publications
Harig, C., Lewis, K.W., Plattner, A., & Simons, F.J. (2015). A Suite of Software Analyzes Data on the Sphere. Eos, 96. doi: 10.1029/2015eo025851

Han, S.C., & Razeghi, S.M. (2017). GPS Recovery of Daily Hydrologic and Atmospheric Mass Variation: A Methodology and Results From the Australian Continent. Journal of Geophysical Research: Solid Earth, 122, 9328-9343. doi: 10.1002/2017jb014603

Harig, C., & Simons, F.J. (2012). Mapping Greenland's mass loss in space and time. Proc Natl Acad Sci U S A, 109, 19934-19937. doi: 10.1073/pnas.1206785109

Simons, F.J., Dahlen, F.A., & Wieczorek, M.A. (2006). Spatiospectral Concentration on a Sphere. SIAM Review, 48, 504-536. doi: 10.1137/s0036144504445765

Jiang Z., Hsu Y., Yuan L., Wei F., Yang X., Tang M., 2022. GNSS2TWS: an open-source MATLAB-based tool for inferring daily terrestrial water storage changes using GNSS vertical data, GPS Solutions, 26:144. doi: 10.1007/s10291-022-01301-8

Jiang, Z., Hsu, Y.-J., Yuan, L., Cheng, S., Feng, W., Tang, M., Yang, X., 2022. Insights into hydrological drought characteristics using GNSS-inferred large-scale terrestrial water storage deficits. Earth and Planetary Science Letters 578. doi: 10.1016/j.epsl.2021.117294

Jiang, Z., Hsu, Y.-J., Yuan, L., Cheng, S., Li, Q., Li, M., 2021. Estimation of daily hydrological mass changes using continuous GNSS measurements in mainland China. Journal of Hydrology 598. doi: 10.1016/j.jhydrol.2021.126349

Jiang, Z., Hsu, Y.-J., Yuan, L., Huang, D., 2021. Monitoring time-varying terrestrial water storage changes using daily GNSS measurements in Yunnan, southwest China. Remote Sensing of Environment 254. doi: 10.1016/j.rse.2020.112249

Jiang, Z., Hsu, Y.J., Yuan, L., Yang, X., Ding, Y., Tang, M., Chen, C., 2021. Characterizing Spatiotemporal Patterns of Terrestrial Water Storage Variations Using GNSS Vertical Data in Sichuan, China. Journal of Geophysical Research: Solid Earth 126. doi: 10.1029/2021jb022398
