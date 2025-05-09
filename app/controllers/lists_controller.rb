class ListsController < ApplicationController
  before_action :set_list, only: [:show, :destroy] #Before running the show or destroy actions, it now runs the set_list method

  def index
    @lists = List.all #fetches all lists from the database and stores them in @lists for the view
  end

  def show
    @bookmark = Bookmark.new  #makes new bookmark
    @review = Review.new(list: @list) #makes a new review that's already associated with the current list "(list: @list)"
  end

  def new
    @list = List.new  #creates blank list object
  end

  def create
    @list = List.new(list_params) #creates new list using submitted form data "(list_params)"
    if @list.save #if the list is saved successfully then it redirects to the "show" pg for that list
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity  #if save is unsuccessful it re-renders the form with a 422 status error
    end
  end

  def destroy
    @list.destroy #deletes selected list
    redirect_to lists_path, status: :see_other  #redirects to the list of all lists (index)
  end

  private

  def set_list
    @list = List.find(params[:id])  #Finds the list by the id from the URL
  end

  def list_params
    params.require(:list).permit(:name) #strong params - only allow the :name attribute from the submitted form for security
  end
end
