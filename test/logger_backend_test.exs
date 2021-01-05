defmodule MessengersLogger.LoggerBackendTest do
  use ExUnit.Case
  use Placebo
  require Logger
  import ExUnit.CaptureLog

  setup do
    {:ok, _} = Logger.add_backend(MessengersLogger.LoggerBackend)

    ExUnit.Callbacks.on_exit(fn ->
      Logger.configure_backend(MessengersLogger.LoggerBackend, [])
      :ok = Logger.remove_backend(MessengersLogger.LoggerBackend)
    end)
  end

  test "exception makes call to messenger" do
    allow(MessengersLogger.Messengers.Telegram.log(any(), any(), any())) |> return(:ok)

    capture_log(fn ->
      spawn(fn -> raise("Raising exception") end)

      Process.sleep(500)
    end)

    assert_called MessengersLogger.Messengers.Telegram.log(any(), any(), any())
  end
end
