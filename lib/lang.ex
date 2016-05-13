defmodule Lang do
  import Meta

  defmacro piece(do: block) do
    quote do
      {:ok, var!(buffer, Lang)} = start_buffer([])
      {:ok, var!(env, Lang)} = start_env
      unquote(block)
      result = render(var!(buffer, Lang))
      :ok = stop_buffer(var!(buffer, Lang))
      :ok = stop_env(var!(env, Lang))
      %Piece{staffs: result}
    end
  end

  def start_buffer(state), do: Agent.start_link(fn -> state end)
  def stop_buffer(buff), do: Agent.stop(buff)
  def put_buffer(buff, content), do: Agent.update(buff, &[content | &1])
  def render(buff), do: Agent.get(buff, &(&1)) |> Enum.reverse

  def start_env(), do: Agent.start_link(fn -> [%{}] end)
  def stop_env(env), do: Agent.stop(env)
  def push_env(env, attr_map) do
    new = Map.merge(get_env(env), attr_map)
    Agent.update(env, &[new | &1])
  end
  def get_env(env), do: Agent.get(env, &(&1)) |> hd
  def pop_env(env), do: Agent.update(env, &tl/1)

  defmacro staff(do: inner) do
    quote do
      put_buffer var!(buffer, Lang),
	%Staff{bpm: get_env(var!(env, Lang))[:bpm],
	       measures: process_notestring(unquote(inner))}
    end
  end

  defmacro bpm(n, do: inner) do
    quote do
      push_env var!(env, Lang),
	%{bpm: unquote(n)}
      unquote(inner)
      pop_env var!(env, Lang)
    end
  end
end
