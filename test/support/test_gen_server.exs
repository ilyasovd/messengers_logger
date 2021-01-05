defmodule MessengersLogger.TestGenServer do
  use GenServer

  def start_link(pid) do
    GenServer.start_link(__MODULE__, pid)
  end

  def raise_exception(pid) do
    GenServer.call(pid, :raise_exception)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call(:raise_exception, _from, _state) do
    raise("Raising exception")
  end

  def terminate(_, state) do
    send(state, "terminating")
  end
end
