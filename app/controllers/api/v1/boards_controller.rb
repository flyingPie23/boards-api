class Api::V1::BoardsController < Api::V1::BaseController

  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :set_board, only: [ :show, :update, :destroy ]


  def index
    @boards = policy_scope(Board)
  end

  def show
    @user = @board.user
  end

  def create
    @board = Board.new(board_params)
    @board.user = current_user
    authorize @board
    if @board.save
      render :show, status: :created
    else
      render_error
    end
  end

  def update
    if @board.update(board_params)
      render :show
    else
      render_error
    end
  end

  def destroy
    @board.destroy
    head :no_content
  end

  private

  def set_board
    @board = Board.find(params[:id])
    authorize @board  # For Pundit
  end

  def board_params
    params.require(:board).permit(:title, :description)
  end

  def render_error
    render json: { errors: @board.errors.full_messages },
      status: :unprocessable_entity
  end
end
