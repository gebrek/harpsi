defmodule Piece do
  defstruct staffs: []

  def play(piece) do
    Parallel.pmap(piece.staffs, &Staff.play/1)
  end
end

defmodule Rest do
  defstruct type: 4
  def is_rest(%Rest{}) do
    true
  end
  def is_rest(_) do
    false
  end
end

defmodule Chord do
  defstruct notes: [], type: 4

  def is_chord(%Chord{}) do
    true
  end
  def is_chord(_) do
    false
  end
end

defmodule Staff do
  defstruct bpm: 120, octave: 4, measures: []

  def play(staff) do
    tagged = tag_note_delays(staff, 0.0)
    Parallel.pmap(tagged, fn({timing, note}) ->
      delayed_spawn_note(round(timing * 1000), note) end)
  end

  def tag_note_delays(staff, delay) do
    tag_note_delays(staff.measures, staff.bpm, delay)
  end
  def tag_note_delays(measure, bpm, delay) do
    case measure do
      [%Rest{type: t}] ->
	[]
      [%Rest{type: t} | tail] ->
	tag_note_delays(tail, bpm, delay + Note.type_time(t, bpm))

      [%Note{name: n, type: t, octave: o}] ->
	[{delay, %Note{name: n, type: t, octave: o}}]
      [%Note{name: n, type: t, octave: o} | tail] ->
	[{delay, %Note{name: n, type: t, octave: o}}
	 | tag_note_delays(tail, bpm, delay + Note.type_time(t, bpm))]

      [%Chord{notes: ns, type: t}] ->
      (for n <- ns, into: [] do
	  {delay, %Note{name: n.name, type: t, octave: n.octave}}
	end)
      [%Chord{notes: ns, type: t} | tail] ->
      (for n <- ns, into: [] do
	  {delay, %Note{name: n.name, type: t, octave: n.octave}}
	end) ++ tag_note_delays(tail, bpm, delay + Note.type_time(t, bpm))

      [] ->
	[]
    end
  end

  defp delayed_spawn_note(delay, note) do
    :timer.sleep(delay)
    IO.inspect {delay, note}
    spawn(Note, :play, [note])
  end
end

defmodule Note do
  defstruct name: "C", type: 4, octave: 4

  def is_note(%Note{}) do
    true
  end
  def is_note(_) do
    false
  end

  def play(note, opts \\ %{}) do
    System.cmd("play", note_args(note, opts))
  end

  def time(note, bpm) do
    type_time(note.type, bpm)
  end
  def type_time(type, bpm) do
    (4 / type) * (60 / bpm)
  end

  defp note_args(note, opts) do
    ["-qn", "synth",
     to_string(4 / note.type),
     Map.get(opts, :type, "pluck"),
     process_note(note),
     "vol", Map.get(opts, :vol, "1")
    ]
  end

  defp process_note(note) do
    note.name <> to_string(note.octave)
  end

  defp valid_notes do
    for names <- String.graphemes("CDEFGAB"),
      types <- [1, 2, 4, 8, 16],
      octaves <- 1..7, into: [] do
      %Note{name: names, type: types, octave: octaves}
    end
  end
end
