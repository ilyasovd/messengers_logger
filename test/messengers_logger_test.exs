defmodule MessengersLoggerTest do
  use ExUnit.Case
  doctest MessengersLogger

  test "greets the world" do
    assert MessengersLogger.hello() == :world
  end
end
