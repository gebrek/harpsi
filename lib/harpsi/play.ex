# defmodule Harpsi.Play do

# 	# def valid_notes do
# 	# 	for n <- 1..7, l <- String.graphemes("CDEFGAB") do
# 	# 		l <> to_string(n)
# 	# 	end
# 	# end

# 	# # defp valid_note?(note) do
# 	# # 	String.contains?(valid_notes, note)
# 	# # end

# 	# def note_args(note, opts) do
# 	# 	["-qn", "synth",
# 	# 	 Keyword.get(opts, :len, "0"),
# 	# 	 Keyword.get(opts, :type, "pluck"), 
# 	# 	 "#{note}",
# 	# 	 "vol", Keyword.get(opts, :vol, "1")
# 	# 	]
# 	# end

# 	# def note(note, opts \\ []) do
# 	# 	System.cmd("play", note_args(note, opts))
# 	# end

# 	# def notes(notes, timing, opts \\ []) do
# 	# 	for note <- notes do
# 	# 		IO.puts "\n"
# 	# 		IO.puts(note)
# 	# 		IO.inspect opts
# 	# 		IO.inspect note_args note, opts
# 	# 		IO.puts "\n"
# 	# 		spawn_note(timing, note, opts)
# 	# 	end
# 	# end

# 	# defp spawn_note(timing, note, opts) do
# 	# 	spawn(Harpsi.Play, :note, [note, opts])
# 	# 	:timer.sleep(timing)
# 	# end

# end
