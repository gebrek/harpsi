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

	def ode_to_joy_full do
		ms = ntc("EEFGGFEDCCDE") ++ ntc("E", 2+2/3) ++ ntc("D", 8) ++ ntc("D", 2) ++
			ntc("EEFGGFEDCCDE") ++ ntc("D", 2+2/3) ++ ntc("C", 8) ++ ntc("C", 2) ++
			ntc("DDECD") ++ ntc("EF", 8) ++ ntc("ECD") ++ ntc("EF", 8) ++ ntc("EDCD") ++ 
			[%Note{name: "G", type: 2, octave: 3}] ++
			ntc("EEFGGFEDCCDE") ++ ntc("D", 2+2/3) ++ ntc("C", 8) ++ ntc("C", 2)

		%Staff{bpm: 180,
					measures: ms}
	end

	def ode_to_joy_bass do
		ms = ntb("CGCGCGC") ++ ntb("GC", 2) ++ ntb("GGGGCGC") ++ ntb("GC", 2)
		%Staff{bpm: 180,
					measures: ms}
	end
	
	# note constructor
	def ntc(note_string, type \\ 4) do
		for x <- String.graphemes(note_string), into: [] do
			%Note{name: x, type: type}
		end
	end
	def ntb(note_string, type \\ 1) do
		for x <- String.graphemes(note_string), into: [] do
			%Note{name: x, type: type, octave: 3}
		end
	end
end
