class BooksController < ApplicationController
   before_action :set_book, only: [:show, :edit, :update, :destroy]
   
  def top

  end

  def index
    #全データ取得
    @books = Book.all.order(created_at: :desc)
    # 今回は一覧画面から投稿するためindex内で空のオブジェクトを生成
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book) #セーブできた時
    else
     @books = Book.all.order(created_at: :desc)
    # @bookで値を取得しないとeachに何も入っていないことになる
     render :index
  
    end
  end



  def show
  end

  def edit
  end

  def update
  
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path
    else
      render :edit
    end
  end

  def destroy
    #データを削除
    @book.destroy
    # 一覧に戻る
    flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
end