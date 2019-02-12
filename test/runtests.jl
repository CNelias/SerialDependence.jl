using Test
using CategoricalDataAnalysis
using MIDI

cd(@__DIR__)
#testing the functions with a piece in C major from Haydn
tester = [MIDI.PITCH_TO_NAME[mod(n.pitch, 12)] for n in getnotes(readMIDIfile("2_2.mid"))]
#filtering out the outside notes
tester = filter(x -> x in(["C","B","A","D","G","E","F"]), tester)

@test cramer_coefficient(d,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],["C","E"])[2][6] == 0.4145144779175194
@test LaggedBivariateProbability(d,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],"C","E")[2][6] == 0.009615384615384616
