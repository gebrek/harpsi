defmodule Sheets do
  import Lang

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

  def times(x, n) do
    for _ <- 1..n, into: [], do: x
  end

  def ctc(note_string, type \\ 4) do
    %Chord{notes: (for x <- String.graphemes(note_string), into: [], do: %Note{name: x}),
	   type: type}
  end

  def chopsticks do
    ms = times(ctc("FG"), 6) ++ times(ctc("EG"), 6) ++ times(ctc("FB"), 6) ++ [ctc("EC", 2)] ++
      times(ctc("EC"), 2) ++ ntc("BA") ++ times(ctc("FG"), 6) ++ times(ctc("EG"), 6)
    %Staff{bpm: 120,
	   measures: ms}
  end
  
  # ad-hoc note constructor
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

  def rosie do
    piece do
      w_opt bpm: 100 do
	staff "d d/8 o3b e/8 d/3 _ _/8 d d/8 o3b e/8"
	w_opt octave: 3 do
	  staff "_/1 _/3 b c/8 _/4" 
	end
      end
    end
  end

  def london_bridge do
    piece do
      w_opt octave: 3, bpm: 100, type: 3 do
	staff "d e d c b c d/2 a b c/2 b c d/2 d e d c b c d/2 a/2 d/2 bg g"
	w_opt type: 2 do
	  staff "g g g g o2d o2d g g g g g g o2d o2d"
	end
      end
    end
  end
end
