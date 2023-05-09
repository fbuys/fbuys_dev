defmodule FbuysDev.Blog.ParserTest do
  use ExUnit.Case
  doctest FbuysDev.Blog.Parser

  alias FbuysDev.Blog.Parser

  describe "parse" do
    test "adds t1 classes" do
      contents = File.read!(Path.expand("./test/fixtures/post_1.md"))
      result = Parser.parse("", contents)
      assert result == {%{}, "\n# Heading 1\n{: .t1}\n\n# With attributes\n{: .class .t1}\n"}
    end
  end
end
