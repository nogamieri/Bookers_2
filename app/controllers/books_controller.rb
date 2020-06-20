class BooksController < ApplicationController
	before_action :authenticate_user!
  # before_action :correct_user, only: [:edit]

  def new
  	
  end
  
  def create
  	@book_new = Book.new(book_params)
  	@book_new.user_id = current_user.id
    @books= Book.all
    if @book_new.save
    flash[:notice]="You have creatad book successfully."
  	redirect_to book_path(@book_new.id)
    else render "books/index"
    end
  end

  def index
    @books= Book.all
    @book_new= Book.new
  end

  def show
  	@book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]="You have updated book successfully."
      redirect_to book_path(@book)
    else render "books/edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end

  def correct_user
    book = Book.find(params[:id])
    user = book.user
    if current_user != user
      redirect_to book_path
    end
  end
end
