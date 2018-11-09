library(rstan)
library(data.table)
library(bayesplot)

trees <- readRDS("data/trees.rds")
dat <- trees[grepl("TSU-CAN", species) & year == 2005 & n > 0]

model <- stan("code/3_ii_trees.stan", data = list(n = nrow(dat), died = dat$died, ntrees = dat$n))

# some functions to play with
mcmc_trace(as.array(model))

mcmc_hist(as.array(model))
mcmc_hist_by_chain(as.array(model))
mcmc_dens_overlay(as.array(model))
mcmc_violin(as.array(model))

mcmc_intervals(as.array(model), pars=c('theta'))
mcmc_areas(as.array(model), pars=c('theta'))

mcmc_scatter(as.array(model))
mcmc_pairs(as.array(model))
mcmc_combo(as.array(model), combo = c("dens", "trace"))