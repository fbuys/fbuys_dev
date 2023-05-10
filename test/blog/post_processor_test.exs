defmodule FbuysDev.Blog.PostProcessTest do
  use ExUnit.Case
  doctest FbuysDev.Blog.PostProcessor

  alias FbuysDev.Blog.PostProcessor

  describe "process" do
    # test "adds t1 classes" do
    #   contents = File.read!(Path.expand("./test/fixtures/post_t1.md"))
    #   result = PostProcessor.parse("", contents)
    #   assert result == {%{}, "\n# Heading 1\n{: .t1 .l-t1}\n\n# With attributes\n{: .class .t1 .l-t1}\n"}
    # end
  end
end
