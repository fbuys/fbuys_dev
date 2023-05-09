defmodule FbuysDev.Blog.Parser do
  @moduledoc """
  """

    @t1_classes ".t1 .l-t1"
  def parse(path, contents) do
    with {:ok, attrs, body} <- parse_contents(path, contents) do
      body = body
      |> String.split(~r/\n(?!{:.+})/)
      |> Enum.map_join("\n", &(add_classes(&1)))
      {attrs, body}
    end
  end

  defp add_classes(text) do
    text
    |> add_t1_classes()
  end

  defp add_t1_classes(text) do
    cond do
      String.match?(text, ~r/^#.+\n(?:{:.+})/) -> String.replace_trailing(text, "}", " #{@t1_classes}}")
      String.match?(text, ~r/^#/) -> text <> "\n{: #{@t1_classes}}"
      true -> text
    end
  end

  defp parse_contents(path, contents) do
    case :binary.split(contents, ["\n---\n", "\r\n---\r\n"]) do
      [_] ->
        {:error, "could not find separator --- in #{inspect(path)}"}

      [code, body] ->
        case Code.eval_string(code, []) do
          {%{} = attrs, _} ->
            {:ok, attrs, body}

          {other, _} ->
            {:error,
             "expected attributes for #{inspect(path)} to return a map, got: #{inspect(other)}"}
        end
    end
  end

end
