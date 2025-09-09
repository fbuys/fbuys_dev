class Blog::PostsController < ApplicationController
  def index
    @grouped_posts = Blog::Post.all
      .select { _1.published_on && _1.published_on < Date.today }
      .sort_by(&:published_on).reverse
      .group_by(&:published_year)
  end

  def show
    @post = Blog::Post.find(request.path.sub(%r{/?blog/posts/}, ""))
  end
end
