class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_article, except: [:index,:new,:create]
  #GET /articles
  def index
    #trae todos los registros de la base de datos para la tabla
    @articles = Article.all
    #Lo asignamos a una variable de clase, para accederlo desde la vista
  end
  #GET /articles/:id
  def show
    #Encontrar un registro por su ID
    @article.update_visits_count
    @comment = Comment.new
  end
  #GET /articles/new
  def new
    @article = Article.new
  end
  #POST /articles
  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new
    end

  end
  #delete "/articles/:id"
  def destroy

    @article.destroy #Elimina el objeto de la BD
    redirect_to articles_path #redirecciona a articles
  end
  #get "/articles/:id/edit"  edit
  def edit

  end
  #put "/ articles/:id"  update
  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end
  def article_params
    params.require(:article).permit(:title,:body)
  end
end