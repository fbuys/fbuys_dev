require "sinatra"
require "decant"
require "kramdown"

module Blog
  Post = Decant.define(dir: "content/blog/posts", ext: "md") do
    frontmatter :title, :published_on

    def published_year
      published_on&.year
    end

    def slug
      File.basename(path, ".md")
    end
  end
end

# Configure Sinatra's Markdown rendering (Kramdown will be used because it's
# required above).
set :markdown,
  input: "GFM",
  smartypants: true,
  views: "content"

get "/" do
  redirect to("/blog")
end

get "/blog" do
  @grouped_posts = Blog::Post.all
    .select { _1.published_on && _1.published_on < Date.today }
    .sort_by(&:published_on).reverse
    .group_by(&:published_year)
  erb :"blog/posts/index"
end

get "/blog/posts/:year/:slub" do |year, slug|
  @post = Blog::Post.find(request.path.sub(%r{/?blog/posts/}, ""))
  erb :"blog/posts/show"
end
