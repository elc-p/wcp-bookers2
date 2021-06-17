class BooksController < ApplicationController
  def index
    @user = current_user
    @book = Book.new
    @books = Book.all

  end
  
  # def new
  #   @book = Book.new
  # end 
  
  
  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: 'You have created book successfully'
    else
      @books = Book.all
      render 'index'
    end
    
  end
  
  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  
  private
  
  def book_params
    params.require(:book).permit(:book_title, :opinion)
  end
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  
end