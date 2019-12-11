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
  def edit
    @shelter = Shelter.find(params[:id])
    @review = Review.find(params[:review_id])
    # binding.pry
  end
  def update
    @shelter = Shelter.find(params[:id])
    @review = Review.find(params[:review_id])

    @review.update({
      title: params[:title],
      rating: params[:rating],
      content: params[:content],
      picture: params[:picture]
      })
      # binding.pry
      if  @review.save
        # binding.pry
        redirect_to "/shelters/#{@review.shelter.id}"
      else
        flash[:notice] = "Review not Updated: Require information missing."
        render :edit
      end
    end
    def destroy
      @review = Review.destroy(params[:review_id])
      @shelter = Shelter.find(params[:id])
      # @review = Review.find(params[:review_id])
      redirect_to "/shelters/#{@shelter.id}"
    end

  private
  def review_params
    params.permit(:title, :rating, :content, :picture)
  end
end
