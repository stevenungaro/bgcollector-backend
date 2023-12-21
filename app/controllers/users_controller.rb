class UsersController < ApplicationController
  def index
    @users = User.includes(:user_games, :reviews).all
    render :index
  end

  def show
    @user = User.find_by(id: params[:id])
    render :show
  end

  def create
    @user = User.create(
      username: params[:username],
      email: params[:email],
      password: params[:password],
    )
    render :show
  end

  def update
    @user = User.find_by(id: current_user.id)
    @user.update(
      username: params[:username] || @user.username,
      email: params[:email] || @user.email,
    )
    if params[:password]
      @user.update(
        password: params[:password],
      )
    end
    render :show
  end

  def destroy
    @user = User.find_by(id: current_user.id)
    @user.destroy
    render json: { message: "User deleted. RIP" }
  end
end
