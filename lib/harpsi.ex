defmodule Harpsi do

	def valid_notes do
		for n <- 1..7, l <- String.graphemes("CDEFGAB") do
			l <> to_string(n)
		end
	end

	def process_note(note) do
		if Enum.member? 

	def note_args(note, opts) do
		["-qn", "synth",
		 Integer.to_string(Keyword.get(opts, :len, 2)),
		 Keyword.get(opts, :type, "pluck"), 
		 process_note(note),
		 "vol", Keyword.get(opts, :vol, "1")
		]
	end

	def note(note, opts \\ []) do
		System.cmd("play", note_args(note, opts))
	end

	def notes(notes, timing, opts \\ []) do
		for note <- notes do
			spawn_note(timing, note, opts)
		end
	end

	defp spawn_note(timing, note, opts) do
		spawn(Harpsi.Play, :note, [note, opts])
		:timer.sleep(timing)
	end

end
