defmodule Sheets do
	def mary_had_a_little_lamb do
		%Staff{bpm: 160,
					 measures: [
						 %Note{name: "B", octave: 4, type: 4}, %Note{name: "A", octave: 4, type: 4},
						 %Note{name: "G", octave: 4, type: 4}, %Note{name: "A", octave: 4, type: 4},
						 %Note{name: "B", octave: 4, type: 4}, %Note{name: "B", octave: 4, type: 4},
						 %Note{name: "B", octave: 4, type: 4}, %Note{name: "A", octave: 4, type: 4},
						 %Note{name: "A", octave: 4, type: 4}, %Note{name: "A", octave: 4, type: 4},
						 %Note{name: "B", octave: 4, type: 4}, %Note{name: "D", octave: 4, type: 4},
						 %Note{name: "D", octave: 4, type: 4}, %Note{name: "B", octave: 4, type: 4},
						 %Note{name: "A", octave: 4, type: 4}, %Note{name: "G", octave: 4, type: 4},
						 %Note{name: "A", octave: 4, type: 4}, %Note{name: "B", octave: 4, type: 4},
						 %Note{name: "B", octave: 4, type: 4}, %Note{name: "B", octave: 4, type: 4},
						 %Note{name: "B", octave: 4, type: 4}, %Note{name: "A", octave: 4, type: 4},
						 %Note{name: "A", octave: 4, type: 4}, %Note{name: "B", octave: 4, type: 4},
						 %Note{name: "A", octave: 4, type: 4}, %Note{name: "G", octave: 4, type: 4},
					 ]}
	end

	def ode_to_joy do
		%Staff{bpm: 150,
					 measures: [
						 %Note{name: "E", octave: 4, type: 4}, %Note{name: "E", octave: 4, type: 4},
						 %Note{name: "F", octave: 4, type: 4}, %Note{name: "G", octave: 4, type: 4},
						 %Note{name: "G", octave: 4, type: 4}, %Note{name: "F", octave: 4, type: 4},
						 %Note{name: "E", octave: 4, type: 4}, %Note{name: "D", octave: 4, type: 4},
						 %Note{name: "C", octave: 4, type: 4}, %Note{name: "C", octave: 4, type: 4},
						 %Note{name: "D", octave: 4, type: 4}, %Note{name: "E", octave: 4, type: 4},
						 %Note{name: "E", octave: 4, type: 6}, %Note{name: "D", octave: 4, type: 8},
						 %Note{name: "D", octave: 4, type: 2}, 
						 %Note{name: "E", octave: 4, type: 4}, %Note{name: "E", octave: 4, type: 4},
						 %Note{name: "F", octave: 4, type: 4}, %Note{name: "G", octave: 4, type: 4},
						 %Note{name: "G", octave: 4, type: 4}, %Note{name: "F", octave: 4, type: 4},
						 %Note{name: "E", octave: 4, type: 4}, %Note{name: "D", octave: 4, type: 4},
						 %Note{name: "C", octave: 4, type: 4}, %Note{name: "C", octave: 4, type: 4},
						 %Note{name: "D", octave: 4, type: 4}, %Note{name: "E", octave: 4, type: 4},
						 %Note{name: "D", octave: 4, type: 6}, %Note{name: "C", octave: 4, type: 8},
						 %Note{name: "C", octave: 4, type: 2},
					 ]}
	end
end
