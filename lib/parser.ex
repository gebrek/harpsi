defmodule Parser do

  defp repeat(_thing, times) when times < 1 do
    []
  end
  defp repeat(thing, times) do
    for _ <- 1..times, into: [], do: thing
  end

  def process_notestring(ns, opts) do
    ns
    |> String.split(" ")
    |> Enum.filter(&(&1 != ""))
    |> process_measures(opts)
  end

  def process_measures(list, opts) do
    list
    |> Enum.map(&process_word(&1, opts))
    |> List.flatten
  end

  def process_word(word, opts) do
    word = String.upcase(word)
    cond do
      String.match?(word, ~r/^O(?<octave>[1-7])(?<word>.*)/) ->
	process_octave(word, opts)
      String.match?(word, ~r/^(?<up_or_down>[<>])(?<word>.*)/) ->
	process_doctave(word, opts)
      String.match?(word, ~r/(?<word>.*)\*(?<times>.*)/) ->
	process_times(word, opts)
      String.match?(word, ~r/(?<word>.*)\/(?<type>.*)/) ->
	process_type(word, opts)
      String.match?(word, ~r<.{2,}>) ->
	process_chord(word, opts)
      String.match?(word, ~r/[A-G_]/) ->
	process_note(word, opts)
      true ->
	raise "Invalid note-string"
    end
  end

  def process_doctave(word, opts) do
    cap = Regex.named_captures(~r/^(?<up_or_down>[<>])(?<word>.*)/, word)
    process_word(cap["word"], Map.put(opts, :octave,
	  opts.octave + (case cap["up_or_down"] do
			   "<" -> -1
			   ">" -> 1
			 end)))
  end

  def process_octave(word, opts) do
    cap = Regex.named_captures(~r/^O(?<octave>[1-7])(?<word>.*)/, word)
    process_word(cap["word"], Map.put(opts, :octave, String.to_integer(cap["octave"])))
  end

  def process_times(word, opts) do
    cap = Regex.named_captures(~r/(?<word>.*)\*(?<times>.*)/, word)
    repeat(process_word(cap["word"], opts), String.to_integer(cap["times"]))
  end

  def process_type(word, opts) do
    cap = Regex.named_captures(~r/(?<word>.*)\/(?<type>.*)/, word)
    process_word(cap["word"], Map.put(opts, :type, String.to_integer(cap["type"])))
  end

  def process_chord(word, opts) do
    %Chord{type: opts.type,
	   notes: (for n <- String.graphemes(word) do
		     process_word(n, opts)
		   end)}
  end

  def process_note(word, opts) do
    if String.match?(word, ~r/[A-G_]/) do
      cond do
	word == "_" ->
	  %Rest{type: opts.type}
	true ->
	  %Note{name: word,
		type: opts.type,
		octave: opts.octave}
      end
    else
      raise "Invalid note #{word}"
    end
  end

end
