# Adapted HLW (2017) Model  

These files implement an annually adapted maximum likelihood procedure to estimate the natural rate of interest in addition to other relevant parameters such as the trend growth rate and unobservable component. For modifications, refer to Kaykhusraw (2023). For further details regarding the original state-space system, refer to Holston, Laubach and Williams (2017).

The function run.hlw.estimation.R is called by run.hlw.R once for each economy. It takes as inputs the key variables for the given economy: log output, inflation, and the real and nominal short-term interest rates, as well as the specified constraints on ar and by. It calls the programs rstar.stageX.R to run the three stages of the HLW estimation. Additionally, it calls the programs median.unbiased.estimator.stageX.R to obtain the signal-to-noise ratios λg and λz. 

