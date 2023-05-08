defmodule FbuysDev.Blog do
  alias FbuysDev.Blog.Post
  alias FbuysDev.Blog.Parser

  use NimblePublisher,
    build: Post,
    from: "./posts/**/*.md",
    as: :posts,
    highlighters: [:makeup_elixir, :makeup_erlang],
    parser: Parser

  # The @posts variable is first defined by NimblePublisher.
  # Let's further modify it by sorting all posts by descending date.
  @posts Enum.sort_by(@posts, & &1.date, {:desc, Date})

  # Let's also get all tags
  @tags @posts |> Enum.flat_map(& &1.tags) |> Enum.uniq() |> Enum.sort()

  # And finally export them
  def all_posts, do: @posts
  def all_tags, do: @tags
end
