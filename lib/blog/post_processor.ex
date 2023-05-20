defmodule FbuysDev.Blog.PostProcessor do
  @moduledoc """
    For more help see: https://github.com/dashbitco/nimble_publisher/issues/10
  """

  def process({tag, _atts, _content, _meta} = attrs) when tag == "h1" do
    attrs
    |> merge_class("t1 l-t1")
  end

  def process({tag, _atts, _content, _meta} = attrs) when tag in ["p", "ul", "ol"] do
    attrs
    |> merge_class("l-post-paragraph c-post-paragraph")
  end

  def process({tag, _atts, _content, _meta} = attrs) when tag == "blockquote" do
    attrs
    |> merge_class("l-post-blockquote c-post-blockquote")
  end

  def process(value), do: value

  # private

  defp merge_class(attrs, class) do
    Earmark.AstTools.merge_atts_in_node(attrs, class: class)
  end
end
