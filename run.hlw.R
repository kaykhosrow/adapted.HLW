
rm(list=ls())

source("data.uk.R")

if (!require("tis")) {install.packages("tis"); library("tis")} 
if (!require("mFilter")) {install.packages("mFilter"); library("mFilter")} 
if (!require("nloptr")) {install.packages("nloptr"); library("nloptr")} 

source("calculate.covariance.R")
source("format.output.R")
source("kalman.log.likelihood.R")
source("kalman.standard.errors.R")
source("kalman.states.R")
source("kalman.states.wrapper.R")
source("log.likelihood.wrapper.R")
source("median.unbiased.estimator.stage1.R") 
source("median.unbiased.estimator.stage2.R")
source("rstar.stage1.R")
source("rstar.stage2.R")
source("rstar.stage3.R")
source("run.hlw.estimation.R") 
source("unpack.parameters.stage1.R") 
source("unpack.parameters.stage2.R") 
source("unpack.parameters.stage3.R") 
source("utilities.R")


a3.constraint <- -0.0025

b2.constraint <- 0.025

sample.start <- c(1701) 
sample.end   <- c(1950)

data.start    <- shiftQuarter(sample.start,-1)
ea.data.start <- shiftQuarter(ea.sample.start,-1)

g.pot.start.index <- 1 + ti(shiftYear(sample.start,-1),'annual')-ti(data.start,'annual')

output.col.names <- c("Date","rstar","g","z","output gap","","All results are output from the Stage 3 model.",rep("",8),"Standard Errors","Date","y*","r*","g","","rrgap")

niter <- 5000

run.se <- TRUE

uk.data <- read.table("input/rstar.data.uk.csv",
                      sep = ',', na.strings = ".", header=TRUE, stringsAsFactors=FALSE)

uk.log.output             <- uk.data$gdp.log
uk.inflation              <- uk.data$inflation
uk.inflation.expectations <- uk.data$inflation.expectations
uk.nominal.interest.rate  <- uk.data$interest
uk.real.interest.rate     <- uk.nominal.interest.rate - uk.inflation.expectations

uk.estimation <- run.hlw.estimation(uk.log.output, uk.inflation, uk.real.interest.rate, uk.nominal.interest.rate,
                                    a3.constraint = a3.constraint, b2.constraint = b2.constraint, run.se = run.se)

one.sided.est.uk <- cbind(uk.estimation$out.stage3$rstar.filtered,
                          uk.estimation$out.stage3$trend.filtered,
                          uk.estimation$out.stage3$z.filtered,
                          uk.estimation$out.stage3$output.gap.filtered)

write.table(one.sided.est.uk, 'output/one.sided.est.uk.csv', row.names = FALSE, col.names = c("rstar","g","z","output gap"), quote = FALSE, sep = ',', na = ".")

output.uk <- format.output(uk.estimation, one.sided.est.uk, uk.real.interest.rate, sample.start, sample.end, run.se = run.se)
write.table(output.uk, 'output/output.uk.csv', col.names = output.col.names, quote=FALSE, row.names=FALSE, sep = ',', na = '')
