using Test
using SerialDependence
using DelimitedFiles

#testing the functions by reproducing the results from C. Weiss's book "An Introduction to Discrete-Valued Time Series".
#I could not find the raw data so I copied the values provided in the book (the raw time-series should be ~1300 elements long), explaining slight numerical differences in results.
pewee = Int64.(readdlm("pewee.txt", ',')[1,:])
@test round(cramer_coefficient(pewee, Int64(4))[1], digits = 2) == 0.46
@test round(cohen_coefficient(pewee, Int64(4))[1], digits = 2) == 0.55
# this one was not in the book, but the plot correctly reproduces the results.
@test round(theils_u(pewee,[1])[1], digits = 2) == 0.55
@test round(H(pewee), digits = 2) == 1.49
