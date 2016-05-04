defmodule Staff do
	defstruct bpm: 120, measures: []

	def play(staff) do
		# tagged = tag_note_lengths(staff.measures, staff.bpm)
		tagged = tag_note_delays(staff.measures, 0.0, staff.bpm)
		# for {timing, note} <- tagged do
		# 	spawn_note(round(timing * 1000), note)
		# end
		Parallel.pmap(tagged, fn({timing, note}) -> 
			delayed_spawn_note(round(timing * 1000), note) end)
	end

	def tag_note_lengths(measure, bpm) do
		case measure do
			[head | tail] ->
				[{Note.time(head, bpm), head} 
				 | tag_note_lengths(tail, bpm)]
			[last] ->
				[{Note.time(last, bpm), last}]
			[] ->
				[]
		end
	end

	def tag_note_delays(measure, delay, bpm) do
		case measure do
			[head | tail] ->
				[{delay, head}
				 | tag_note_delays(tail, delay + Note.time(head, bpm), bpm)]
			[last] ->
				[{delay, last}]
			[] ->
				[]
		end
	end

	defp spawn_note(timing, note) do
		IO.inspect({timing, note})
		spawn(Note, :play, [note])
		:timer.sleep(timing)
	end

	defp delayed_spawn_note(delay, note) do
		:timer.sleep(delay)
		IO.inspect {delay, note}
		spawn(Note, :play, [note])
	end		
end

defmodule Note do
	defstruct name: "C", type: 4, octave: 4

	def play(note, opts \\ %{}) do
		System.cmd("play", note_args(note, opts))
		# :timer.kill_after(100 * Map.get(opts, :len, 2))
	end

	def note_args(note, opts) do
		["-qn", "synth",
		 to_string(2 / note.type),
		 Map.get(opts, :type, "pluck"),
		 process_note(note),
		 "vol", Map.get(opts, :vol, "1")
		]
	end

	def process_note(note) do
		note.name <> to_string(note.octave)
	end

	def valid_notes do
		for names <- String.graphemes("CDEFGAB"),
		types <- [1, 2, 4, 8, 16],
		octaves <- 1..7, into: [] do
			%Note{name: names, type: types, octave: octaves}
		end
	end

	def time(note, bpm) do
		(4 / note.type) * (60 / bpm)
	end
end
