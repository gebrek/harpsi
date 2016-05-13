defmodule Meta do

  def repeat(_thing, times) when times < 1 do
    []
  end
  def repeat(thing, times) do
    for _ <- 1..times, into: [], do: thing
  end

  def process_notestring(ns) do
    ns
    |> String.split(" ")
    |> Enum.filter(&(&1 != ""))
    |> process_measures
  end

  def process_measures(list) do
    list
    |> Enum.map(&process_word/1)
    |> List.flatten
  end

  def process_word(word, opts \\ %{}) do
    word = String.upcase(word)
    cond do
      String.match?(word, ~r<^O[1-7].*>) ->
	process_octave(word, opts)
      String.match?(word, ~r<.*\*.*>) ->
	process_times(word, opts)
      String.match?(word, ~r<.*/.*>) ->
	process_type(word, opts)
      String.match?(word, ~r<.{2,}>) ->
	process_chord(word, opts)
      String.match?(word, ~r<^.$>) ->
	process_note(word, opts)
      true ->
	IO.puts "else"
    end
  end

  def process_octave(word, opts) do
    cap = Regex.named_captures(~r/^O(?<octave>[1-7])(?<word>.*)/, word)
    IO.inspect cap
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
    %Chord{type: Map.get(opts, :type, 4),
	   notes: (for n <- String.graphemes(word) do
		     process_word(n, opts)
		   end)}
  end
  
  def process_note(word, opts) do
    if String.match?(word, ~r/[A-G_]/) do
      cond do
	word == "_" ->
	  %Rest{type: Map.get(opts, :type, 4)}
	true ->
	  %Note{name: word,
		type: Map.get(opts, :type, 4),
		octave: Map.get(opts, :octave, 4)}
      end
    else
      raise "Invalid note #{word}"
    end
  end
  
end
