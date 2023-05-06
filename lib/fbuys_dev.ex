defmodule FbuysDev do
  @moduledoc """
  Documentation for `FbuysDev`.
  """

  use Phoenix.Component
  import Phoenix.HTML

  alias FbuysDev.Blog

  @output_dir "./dist"
  File.mkdir_p!(@output_dir)

  def build() do
    posts = Blog.all_posts()

    render_file("index.html", index(%{posts: posts}))

    for post <- posts do
      dir = Path.dirname(post.path)

      if dir != "." do
        File.mkdir_p!(Path.join([@output_dir, dir]))
      end

      render_file(post.path, post(%{post: post}))
    end

    :ok
  end

  def render_file(path, rendered) do
    safe = Phoenix.HTML.Safe.to_iodata(rendered)
    output = Path.join([@output_dir, path])
    File.write!(output, safe)
  end

  def post(assigns) do
    ~H"""
    <.layout>
      <%= raw @post.body %>
    </.layout>
    """
  end

  def index(assigns) do
    ~H"""
    <.layout>
      <h1>fbuys.dev</h1>
      <h2>Posts!</h2>
      <ul>
        <li :for={post <- @posts}>
          <a href={post.path}> <%= post.title %> </a>
        </li>
      </ul>
    </.layout>
    """
  end

  def layout(assigns) do
    ~H"""
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>fbuys.dev</title>
        <link rel="stylesheet" href="/assets/app.css" />
        <script type="text/javascript" src="/assets/app.js" />
      </head>
      <body>
        <%= render_slot(@inner_block) %>
      </body>
    </html>
    """
  end
end
