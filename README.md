# Adapted HLW (2017) Model  

These files implement an annually adapted maximum likelihood procedure to estimate the natural rate of interest in addition to other relevant parameters such as the trend growth rate and unobservable component. For modifications, refer to Kaykhusraw (2023). For further details regarding the original state-space system, refer to Holston, Laubach and Williams (2017).

The function run.hlw.estimation.R is called by run.hlw.R once for each economy. It takes as inputs the key variables for the given economy: log output, inflation, and the real and nominal short-term interest rates, as well as the specified constraints on ar and by. It calls the programs rstar.stageX.R to run the three stages of the HLW estimation. Additionally, it calls the programs median.unbiased.estimator.stageX.R to obtain the signal-to-noise ratios λg and λz. 

The programs unpack.parameters.stageX.R set up coefficient matrices for the corresponding state-space models for the given parameter vectors. In all stages, the model imposes the constraint by ≥ 0.025. In stages 2 and 3, it imposes ar ≤ −0.0025. These constraints are labeled as a3.constraint and b2.constraint, respectively, in the code.

The programs rstar.stageX.R run the models in stages 1-3 of the HLW estimation.

The function median.unbiased.estimator.stage1.R computes the exponential Wald statistic of Andrews and Ploberger (1994) for a structural break with unknown break date from the first difference of the preliminary estimate of the natural rate of output from the stage 1 model to obtain the median unbiased estimate of λg.

The function median.unbiased.estimator.stage2.R applies the exponential Wald test for an intercept shift in the IS equation at an unknown date to obtain the median unbiased estimate of λz, taking as input estimates from the stage 2 model.

Within the program kalman.states.R, the function kalman.states() calls kalman.states.filtered() and kalman.states.smoothed() to apply the Kalman filter and smoother. It takes as input the coefficient matrices for the given state-space model as well as the conditional expectation and covariance matrix of the initial state. kalman.states.wrapper.R is a wrapper function for kalman.states.R that specifies inputs based on the estimation stage.

The function kalman.log.likelihood.R takes as input the coefficient matrices of the given state-space model and the conditional expectation and covariance matrix of the initial state and returns the log likelihood value and a vector with the log likelihood at each time t. log.likelihood.wrapper.R is a wrapper function for kalman.log.likelihood.R that specifies inputs based on the estimation stage.

The function kalman.standard.errors.R computes confidence intervals and corresponding standard errors for the estimates of the states using Hamilton’s (1986) Monte Carlo procedure that accounts for both filter and parameter uncertainty.

The function calculate.covariance.R calculates the covariance matrix of the initial state from the gradients of the likelihood function. The function format.output.R generates a dataframe to be written to a CSV containing one-sided estimates, parameter values, standard errors, and other statistics of interest.

The function calculate.covariance.R calculates the covariance matrix of the initial state from the gradients of the likelihood function. The function format.output.R generates a dataframe to be written to a CSV containing one-sided estimates, parameter values, standard errors, and other statistics of interest.

For each economy, the final section of run.hlw.R reads in prepared data, runs the HLW estimation by calling run.hlw.estimation.R, and saves one-sided estimates and a spreadsheet of output.
