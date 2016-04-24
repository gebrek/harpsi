defmodule Harpsi do

	defmacro with_opts(opts, do: block) do
		quote do
			Enum.map unquote(block), fn(x) -> 	# &(Enum.map &1, fn(x) -> IO.puts x end)
			end
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

	def note(note, opts \\ []) do
		System.cmd("play", note_args(note, opts))
		:timer.kill_after (100 * Map.get(opts, :len, 2))
  end

	def notes(notes, timing, opts \\ []) do
		for note <- notes do
			spawn_note(timing, note, opts)
		end
	end

	defp spawn_note(timing, note, opts) do
		child = spawn(Harpsi.Play, :note, [note, opts])
		:timer.sleep(timing)
		Process.exit(child, :kill)
	end

end

# ~w(B A G A B B B A A A B D D B A G A B B B B A A B A G)
