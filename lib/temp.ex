defmodule Temp do
  import Lang

  def auder do
    piece do
      w_opt bpm: 120, octave: 3, type: 3 do
	staff "a b o4c"		
      end
    end
  end
end
