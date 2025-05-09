class BookmarksController < ApplicationController
  before_action :set_bookmark, only: :destroy  #:set_bookmark runs only before destroy, fetching the bookmark to delete
  before_action :set_list, only: [:new, :create]  #:set_list runs before new and create, since you need the parent list when making a new bookmark

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params) #creates bookmark using form data
    @bookmark.list = @list  #Sets the list association manually since list_id may not be passed in params
    if @bookmark.save
      redirect_to list_path(@list)
    else
      @review = Review.new  #makes a blank review
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark.destroy #deletes bookmark
    redirect_to list_path(@bookmark.list), status: :see_other #redirects to the associated list's page
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])  #Finds a Bookmark by its id (from the URL)
  end

  def set_list
    @list = List.find(params[:list_id]) #Finds the parent list using list_id from the URL
  end
end
