defmodule WheatherApi.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/hello" do
    send_resp(conn, 200, "world")
  end

  get "/proxy" do
    case WheatherApi.Api.get("721943") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        response = body 
          |> Enum.reverse
          |> Enum.at(0)
          |> Jason.encode!
          
        send_resp(conn, 200, response)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        send_resp(conn, 404, "Not found :(")
      {:error, %HTTPoison.Error{reason: reason}} ->
        send_resp(conn, 500, reason)
    end
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
