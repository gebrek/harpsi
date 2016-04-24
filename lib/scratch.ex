# quote do
# 	Harpsi.process_note "C"
# end
# # => {{:., [], [{:__aliases__, [alias: false], [:Harpsi]}, :process_note]}, [],
# # =>  ["C"]}

# quote do
# 	Harpsi.valid_notes
# end
# # => {{:., [], [{:__aliases__, [alias: false], [:Harpsi]}, :valid_notes]}, [], []}

# quote do
# 	for n <- 1..7, 1 <- String.graphemes("CDEFGAB") do
# 		1 <> to_string(n)
# 	end
# end

# # => {:for, [],
# # =>  [{:<-, [],
# # =>    [{:n, [], Elixir}, {:.., [context: Elixir, import: Kernel], [1, 7]}]},
# # =>   {:<-, [],
# # =>    [1,
# # =>     {{:., [], [{:__aliases__, [alias: false], [:String]}, :graphemes]}, [],
# # =>      ["CDEFGAB"]}]},
# # =>   [do: {:<>, [context: Elixir, import: Kernel],
# # =>     [1, {:to_string, [context: Elixir, import: Kernel], [{:n, [], Elixir}]}]}]]}

defmodule Sample do

	def lamb do
		~w(B A G A B B B A A A B D D B A G A B B B B A A B A G)
	end

	def plamb do
		Harpsi.notes(lamb, 300)
	end

	def theme_pair do
		[~w(B B B A), ~w(G A G A)]
	end
	
	def lin_seq do
		Enum.map(theme_pair, fn(x) -> Harpsi.notes(x, 1000) end)
	end

	def par_seq do
		Parallel.pmap(theme_pair, fn(x) -> Harpsi.notes(x, 1000) end)
	end

end

