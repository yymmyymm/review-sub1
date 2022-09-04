class SearchesController < ApplicationController
  before_action :authenticate_user!

 def search
    @range = params[:range]
    @word = params[:word]
    @search = params[:search]
  if @range == 'User'
    @users = User.search_for(@word,@search)
  else
    @books = Book.search_for(@word,@search)
  end
 end

end
