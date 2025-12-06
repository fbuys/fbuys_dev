require "sinatra"
require "decant"
require "kramdown"
require "rouge"

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

configure :development do
  # Disable host authorization in development to allow access from any host.
  set :host_authorization, {permitted_hosts: []}
end

# Configure Sinatra's Markdown rendering (Kramdown will be used because it's
# required above).
set :markdown,
  input: "GFM",
  smartypants: true,
  views: "content"

get "/" do
  @grouped_posts = grouped_posts_by_year
  erb :home
end

get "/blog" do
  @grouped_posts = grouped_posts_by_year
  erb :"blog/posts/index"
end

get "/blog/posts/:year/:slub" do |year, slug|
  @post = Blog::Post.find(request.path.sub(%r{/?blog/posts/}, ""))
  @body_class = "blog-post-page"
  erb :"blog/posts/show"
end

private

def grouped_posts_by_year
  Blog::Post.all
    .select { _1.published_on && _1.published_on <= Date.today }
    .sort_by(&:published_on).reverse
    .group_by(&:published_year)
end
