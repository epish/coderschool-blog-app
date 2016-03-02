class ArticlesController < ApplicationController
  
  # GET /articles
  # GET /articles.json
  def index
    if params[:search]
      @articles = Article.search(params[:search]).order("created_at DESC")
    else
      @articles = Article.all
    end
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)


  end
 
  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
   
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
   
    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :body)
    end

end
