defmodule FbuysDev.Blog.Post do
  @enforce_keys [:id, :author, :title, :body, :tags, :date, :path]
  defstruct [:id, :author, :title, :body, :excerpt, :tags, :date, :path]

  def build(filename, attrs, body) do
    path = Path.rootname(filename)
    [year, month_day_id] = path |> Path.split() |> Enum.take(-2)
    [month, day, id] = String.split(month_day_id, "-", parts: 3)
    date = Date.from_iso8601!("#{year}-#{month}-#{day}")
    path = path <> ".html"
    excerpt = excerpt(attrs, body)

    IO.inspect(excerpt)

    struct!(
      __MODULE__,
      [id: id, date: date, body: body, path: path, excerpt: excerpt] ++ Map.to_list(attrs)
    )
  end

  defp excerpt(%{excerpt: excerpt}, _body), do: excerpt

  defp excerpt(_attrs, body) do
    body
    |> String.split("<!-- more -->")
    |> (fn [excerpt | _] -> excerpt end).()
  end
end
