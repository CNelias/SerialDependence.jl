using Test
using DelimitedFiles, CSV
using MusicManipulations

cd(@__DIR__)

include("..\\src\\SerialDependence.jl")

#testing the functions by reproducing the results from C. Weiss's book "An Introduction to Discrete-Valued Time Series".
pewee = Int64.(readdlm("C:\\Users\\cnelias\\Desktop\\PHD\\StandardTools.jl\\test\\pewee.txt", ',')[1,:])

# @test round(cramer_coefficient(tester,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],["C","E"])[2][6]; digits = 5) == round(0.4145144779175194; digits = 5)
# @test round(LaggedBivariateProbability(tester,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],"C","E")[2][6]; digits = 5) == round(0.009615384615384616; digits = 5)
# @test entropy(z) == 1.75
# @test conditional_entropy(y,x) == 0.5
# @test round(Theils_U(tester,collect(1:30))[3];digits = 5) == round(0.0747438636520575; digits = 5)
