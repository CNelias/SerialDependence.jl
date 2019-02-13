using Test
using CategoricalDataAnalysis
using MIDI

cd(@__DIR__)

#testing the functions with a piece in C major from Haydn
#and filtering out the outside notes
tester = [MIDI.PITCH_TO_NAME[mod(n.pitch, 12)] for n in getnotes(readMIDIfile("2_2.mid"))]
tester = filter(x -> x in(["C","B","A","D","G","E","F"]), tester)
x = [0,1,0,1,0,1,0,1]
y = [0,0,1,0,0,0,1,0]
z = [1,1,1,1,2,2,3,4]

@test round(cramer_coefficient(tester,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],["C","E"])[2][6]; digits = 5) == round(0.4145144779175194; digits = 5)
@test round(LaggedBivariateProbability(tester,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],"C","E")[2][6]; digits = 5) == round(0.009615384615384616; digits = 5)
@test entropy(z) == 1.75
@test conditional_entropy(y,x) == 0.5
@test round(Theils_U(tester,collect(1:30))[3];digits = 5) == round(0.0747438636520575; digits = 5)
