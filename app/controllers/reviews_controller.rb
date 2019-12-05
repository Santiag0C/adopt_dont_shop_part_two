class ReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    @shelter = Shelter.find(params[:id])
    # @shelter.reviews.create(review_params)
    @shelter.reviews.new(review_params)
    if @shelter.save
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:notice] = "Review not created: Require information missing."
      render :new
    end
  end

  private
  def review_params
    params.permit(:title, :rating, :content, :picture)
  end
end
