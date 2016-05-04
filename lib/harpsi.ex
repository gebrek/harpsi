defmodule Chord do
	defstruct notes: []
end

defmodule Note do
	defstruct name: "", type: 4, octave: 4, stamp: 0
end

defmodule Harpsi do
	def default_opts(opts \\ %{}) do
		# completes the opts map with the default args,
		# or overrides with specified input
		# also serves as an ad hoc specification of options
		%{time_sig: Map.get(opts, :time_sig, 4),
			note_type: Map.get(opts, :note_type, 4),
			octave: Map.get(opts, :octave, 4)}
	end

	def process_measure(measure, %{note_type: type}) do
		for {place, stamp} <- String.split(measure, " "), into: [] do
			IO.inspect place
			%Note{name: cond do
						 String.contains?(place, "/") ->
							 pieces = String.split(place, "/")
							 hd(pieces)
						 true ->
							 place
					 end,
						type: cond do
							String.contains?(place, "/") ->
								hd(tl(String.split(place, "/")))
							true ->
								type
						end}
		end
	end

	def process_chord()















	def with_opts(opts, do: block) do
		notes = String.upcase(block)
		|> String.split(" ")
		|> Enum.map(fn(x) -> String.to_atom x end)
		for n <- notes, into: [] do
			{n, opts}
		end
	end

	def valid_notes do
		for n <- 1..7, l <- String.graphemes("CDEFGAB") do
			l <> to_string(n)
		end
	end

	def process_note(note, opts) do
		cond do
			Enum.member?(String.graphemes("CDEFGAB"), note) ->
				n = note <> "4"
			Enum.member?(valid_notes, note) ->
				n = note
			true ->
				raise "error"
		end
	end

	def mod_octave(oct, oct: mod) do
		cond do
			String.contains? mod, "+" ->
				to_string(String.to_integer(oct) + String.to_integer(String.replace(mod, "+", "")))
			String.contains? mod, "-" ->
				to_string(String.to_integer(oct) - String.to_integer(String.replace(mod, "-", "")))
			true ->
				mod
		end
	end

	def note_args(note, opts) do
		["-qn", "synth",
		 Integer.to_string(Map.get(opts, :len, 2)),
		 Map.get(opts, :type, "pluck"), 
		 process_note(note, opts),
		 "vol", Map.get(opts, :vol, "1")
		]
	end

	def note(note, opts \\ %{}) do
		System.cmd("play", note_args(note, opts))
		:timer.kill_after (100 * Map.get(opts, :len, 2))
  end

	def notes(notes, timing, opts \\ %{}) do
		for note <- notes do
			spawn_note(timing, note, opts)
		end
	end

	defp spawn_note(timing, note, opts) do
		child = spawn(Harpsi, :note, [note, opts])
		:timer.sleep(timing)
		Process.exit(child, :kill)
	end

end

# ~w(B A G A B B B A A A B D D B A G A B B B B A A B A G)
