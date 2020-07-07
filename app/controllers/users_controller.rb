class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      @user.errors.full_messages
      render :edit
    end
  end

  #一覧ページ用のアクション
  def following
    @user = User.find(params[:id])
    @users = @user.followings.page(params[:page]).per(5)
    render 'following'
  end

    #一覧ページ用のアクション
  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(5)
    render 'followers'
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
