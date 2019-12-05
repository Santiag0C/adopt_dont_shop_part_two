class ReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    @shelter = Shelter.find(params[:id])
    review = @shelter.reviews.new(review_params)

    if review.save
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:notice] = 'Review Not Created! Make Sure To Fill In Title, Rating, And Content!'
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
    @shelter = Shelter.find(@review.shelter_id)
  end

  def update
    @review = Review.find(params[:id])
    @shelter = Shelter.find(@review.shelter_id)
    review = Review.find(params[:id])
    if review.update(review_params)
    # if review.save
    #   # review.update({
    #   #              title: params[:title],
    #   #              rating: params[:rating],
    #   #              content: params[:content],
    #   #              picture: params[:picture]
    #   #   })
      redirect_to "/shelters/#{review.shelter.id}"
    else
      flash[:notice] = 'Review Not Created! Make Sure To Fill In Title, Rating, And Content!'
      render :edit
    end
  end

  def destroy
    shelter = Review.find(params[:id]).shelter
    review = Review.find(params[:id])
    review.destroy

    redirect_to "/shelters/#{shelter.id}"
  end

    ########### PRIVATE METHODS ###########

    private

    def review_params
      params.permit(:title, :rating, :content, :picture)
      # params.permit(:picture, :optional => true)
    end
end
