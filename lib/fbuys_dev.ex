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
      <h1 class="t1 l-t1">Posts!</h1>
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
        <link rel="stylesheet" href={"/assets/app.css?#{asset_hash()}"} />
        <script type="text/javascript" src={"/assets/app.js?#{asset_hash()}"} />
      </head>
      <body class="l-page">
        <main tabindex="-1" id="main-content" class="l-wrapper">
          <%= render_slot(@inner_block) %>
        </main>
        <.footer />
      </body>
    </html>
    """
  end

  def footer(assigns) do
    ~H"""
    <footer class="l-footer c-footer">
      <article class="l-wrapper c-footer">
        <h2 class="t1 l-t1">Footer</h2>
        <p class="l-paragraph">
          This site is part of my work as I learn in public, and I use it to share my
          thoughts and experiences on a variety of topics, including software development
          and personal development. 
        </p>
        <p class="l-paragraph">
          You'll find a mix of full-length essays and shorter notes here, and I hope you
          find something of value.
        </p>
        <p class="l-paragraph">
          Thank you for visiting, and I hope you enjoy your time on my website.
        </p>
        <nav class="l-footer-nav c-footer-nav">
          <a href="/" class="c-footer-link">home</a>
          <!-- More links go here-->
        </nav>
        <p class="l-copyright s1">
          Copyright &copy; <script>document.write(new Date().getFullYear())</script> |
          Built with 💛 by Francois Buys
      </p>
      </article>
    </footer>
    """
  end

  defp asset_hash(), do: UUID.uuid4()
end
