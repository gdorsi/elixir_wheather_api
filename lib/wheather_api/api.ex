defmodule WheatherApi.Api do
  use HTTPoison.Base

  @expected_fields ~w(
    min_temp max_temp
  )

  def process_request_url(id) do
    "https://www.metaweather.com/api/location/" <> id <> "/"
  end

  def process_response_body(body) do
    body
    |> Jason.decode!
    |> Map.get("consolidated_weather")
    |> Enum.map(fn(v) -> Map.take(v, @expected_fields) end)
  end
end
