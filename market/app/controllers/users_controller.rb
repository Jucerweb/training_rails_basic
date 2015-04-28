class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def follow
    respond_to do |format|
      if current_user.follow!(post_params)
        format.json {head :no_content}
      else
        format.json {render json: "Error", status: :unprocessable_entity}
      end
    end
  end
  private
  def post_params
    params.require(:user).permit(:friend_id)
  end
end