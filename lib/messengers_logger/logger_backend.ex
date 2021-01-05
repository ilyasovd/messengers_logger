defmodule MessengersLogger.LoggerBackend do
  alias MessengersLogger.Messengers.Telegram

  @behaviour :gen_event

  def init(_) do
    {:ok, %{level: :error}}
  end

  def handle_call({:configure, _options}, state) do
    {:ok, :ok, state}
  end

  def handle_event({_level, gl, {Logger, _, _, _}}, state) when node(gl) != node() do
    {:ok, state}
  end

  def handle_event({level, _gl, {Logger, msg, _, meta}}, state) do
    log(level, msg, meta)

    {:ok, state}
  end

  def handle_event(_, state) do
    {:ok, state}
  end

  def handle_info(_, state) do
    {:ok, state}
  end

  defp log(level, msg, meta) do
    Telegram.log(level, msg, meta)
  end
end
