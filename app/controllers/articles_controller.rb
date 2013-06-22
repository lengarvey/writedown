class ArticlesController < ApplicationController
  def show
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    if request.xhr?
      render :partial => 'display_html'
    else
      render :show
    end
  end
end
