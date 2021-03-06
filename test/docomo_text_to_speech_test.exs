defmodule DocomoTextToSpeechTest do
  use ExUnit.Case
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest DocomoTextToSpeech, except: [run: 7, run!: 7]
  doctest DocomoTextToSpeech.Parser

  @text "I Was Born To Love Elixir"

  setup_all do
    HTTPoison.start()
  end

  test "run" do
    use_cassette "httpoison_post" do
      {:ok, body} = DocomoTextToSpeech.run(@text)
      assert body
    end

    use_cassette "httpoison_post_error" do
      {:error, body, %{"Content-Type" => "application/json"}, status_code} =
        DocomoTextToSpeech.run(@text)

      assert body
      assert status_code
    end
  end
end
