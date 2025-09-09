Blog::Post = Decant.define(dir: "blog/posts", ext: "md") do
  frontmatter :title, :published_on

  def html
    Blog::Content.as_html(content)
  end

  def published_year
    published_on&.year
  end

  def slug
    File.basename(path, ".md")
  end
end
