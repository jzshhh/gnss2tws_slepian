# gnss2tws_slepian
GNSS2TWS_Slepian: A software to recover daily GNSS-inverted terrestrial water storage changes based on Slepian basis functions
# Attribution
The primary purpose of this code is to achieve the recovery of daily large-scale terrestrial water storage (TWS) changes from GNSS-observed crustal vertical positions. Differing from the widely-used spatial-domain inversion strategy based on Green's function method, our inversion modeling is implemented in the spectral domain based on Slepian basis functions, which aims to infer daily large-scale TWS changes using sparsely distributed GNSS vertical data. We assume that the potential users are familiar with the Matlab language programming, PCA decomposition, inversion method, and mass loading theory. The code has been written in MATLAB (version 2018b and 2023b) and has been tested on Windows (version 11) operating systems.
Readers can download the complete software (including the code and one example (all input data)) from GitHub (https://github.com/jzshhh/gnss2tws_slepian) and we also release this open-source tool (including the code and one example (all input/output data)) on Zenodo (https://doi.org/10.5281/zenodo.8080098). There are no additional requirements except for the MATLAB language running environment and some basic toolboxes. In this public edition 1.0 of GNSS2TWS_Slepian, we provide an example to investigate the spatiotemporal TWS changes and to characterize hydrological extremes in the Western United States. Readers can directly run this example without additional operations.
# To acknowledge use of this software, please cite the following publications
Jiang Z., Hsu Y., Yuan L., Wei F., Yang X., Tang M., 2022. GNSS2TWS: an open-source MATLAB-based tool for inferring daily terrestrial water storage changes using GNSS vertical data, GPS Solutions, 26:144. doi: 10.1007/s10291-022-01301-8

Jiang, Z., Hsu, Y.-J., Yuan, L., Cheng, S., Feng, W., Tang, M., Yang, X., 2022. Insights into hydrological drought characteristics using GNSS-inferred large-scale terrestrial water storage deficits. Earth and Planetary Science Letters 578. doi: 10.1016/j.epsl.2021.117294

Jiang, Z., Hsu, Y.-J., Yuan, L., Cheng, S., Li, Q., Li, M., 2021. Estimation of daily hydrological mass changes using continuous GNSS measurements in mainland China. Journal of Hydrology 598. doi: 10.1016/j.jhydrol.2021.126349

Jiang, Z., Hsu, Y.-J., Yuan, L., Huang, D., 2021. Monitoring time-varying terrestrial water storage changes using daily GNSS measurements in Yunnan, southwest China. Remote Sensing of Environment 254. doi: 10.1016/j.rse.2020.112249

Jiang, Z., Hsu, Y.J., Yuan, L., Yang, X., Ding, Y., Tang, M., Chen, C., 2021. Characterizing Spatiotemporal Patterns of Terrestrial Water Storage Variations Using GNSS Vertical Data in Sichuan, China. Journal of Geophysical Research: Solid Earth 126. doi: 10.1029/2021jb022398
