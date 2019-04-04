defmodule WheatherApiTest do
  use ExUnit.Case
  doctest WheatherApi

  test "greets the world" do
    assert WheatherApi.hello() == :world
  end
end
