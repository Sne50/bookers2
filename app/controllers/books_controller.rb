class BooksController < ApplicationController
  def new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      @book_n =Book.new
      render :index
    end
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def show
     @book = Book.find(params[:id])
     @user = @book.user
     @book_n =Book.new
  end

  def edit
     @book = Book.find(params[:id])
     unless @book.user.id == current_user.id
       redirect_to books_path
     end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:notice] = "Book was successfully destroyed."
      redirect_to '/books'
    else
      @books = Book.all
      render :index
    end
  end


  private

  def book_params
     params.require(:book).permit(:title, :body)
  end
end
