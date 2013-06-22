class ArticlesController < ApplicationController
  def show
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    render :show
  end
end
