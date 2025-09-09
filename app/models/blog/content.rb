class Blog::Content
  def self.as_html(content)
    template = ERB.new(content)
    rendered_erb = template.result()
    result = Kramdown::Document.new(rendered_erb, input: "GFM").to_html
    result.html_safe
  end
end
