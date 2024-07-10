class Api::V1::ArticlesController < Api::V1::BaseController

  acts_as_token_authentication_handler_for User
  before_action :set_article, only: [:destroy, :update, :show]

  def index
    @articles = policy_scope(Articles)
  end

  def show
  end


  def create
    @article = Article.new(article_params)
    @article.user = current_user
    @board = Board.find(params[:board_id])

    @article.board = @board

    authorize @article
    if @article.save
      render :show, status: :created
    else
      render_error
    end
  end

  def update
    if @article.update(article_params)
      render :show
    else
      render_error
    end
  end


  def destroy
    @article.destroy
    head :no_content
    # No need to create a `destroy.json.jbuilder` view
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end

  def set_article
    @article = Article.find(params[:id])
    authorize @article  # For Pundit
  end

end
