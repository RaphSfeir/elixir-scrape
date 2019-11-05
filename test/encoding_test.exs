defmodule EncodingTest do
  use ExUnit.Case
  alias Scrape.Fetch
  @moduletag :external

  test "multiple feeds with errors" do
    result = File.stream!("../buggy_feeds.csv")
    |> CSV.decode
    |> Enum.take(5000)
    |> IO.inspect
    |> Stream.map(fn 
      {:ok, url} -> 
        IO.inspect "connecting to #{url}"
        IO.inspect Scrape.feed(url)
    end)
    |> Stream.run

    html = Fetch.run "http://www.bbc.com"
    assert html =~ "BBC"
  end
end
