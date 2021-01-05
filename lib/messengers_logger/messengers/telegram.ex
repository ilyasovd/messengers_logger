defmodule MessengersLogger.Messengers.Telegram do
  def log(level, msg, meta) do
    IO.inspect(%{level: level, msg: msg, meta: meta})
  end
end
