using Test
using SerialDependence
using DelimitedFiles

#testing the functions by reproducing the results from C. Weiss's book "An Introduction to Discrete-Valued Time Series".
#I was not able to get my hands the full time-series, C. weiss says it is ~1300 elements long, which explains the slight numerical differences in values.
pewee = Int64.(readdlm("pewee.txt", ',')[1,:])
@test round(cramer_coefficient(pewee, 4)[1], digits = 2) == 0.46
@test round(cohen_coefficient(pewee, 4)[1], digits = 2) == 0.55
# this one was not in the book, but the plot correctly reproduces the results.
@test round(theils_u(pewee,[1])[1], digits = 2) == 0.55
@test round(H(pewee), digits = 2) == 1.49
