defmodule FbuysDev.Blog.PostProcessor do
  @moduledoc """
    For more help see: https://github.com/dashbitco/nimble_publisher/issues/10
  """

  def process({tag, atts, content, meta}) when tag == "h1" do
    merge_class({tag, atts, content, meta}, "t1 l-t1")
  end

  def process({tag, atts, content, meta}) when tag in ["p", "ul"] do
    merge_class({tag, atts, content, meta}, "l-post-paragraph")
  end

  def process(value), do: value

  # private

  defp merge_class({tag, atts, content, meta}, class) do
    Earmark.AstTools.merge_atts_in_node({tag, atts, content, meta}, class: class)
  end
end
