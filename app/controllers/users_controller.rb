class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.permit(:user))
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

end
