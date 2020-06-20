class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: [:edit, :update]

  def show
  	@user = User.find(params[:id])
    @book_new = Book.new
    @books = @user.books
  end

  def index
    @book = Book.new
    @users= User.all
  end


  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render "users/edit"
    end
  end

  private
  	def user_params
  		params.require(:user).permit(:name, :profile_image, :introduction)
    end
    def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to user_path(@current_user.id)
    end
  end
end
