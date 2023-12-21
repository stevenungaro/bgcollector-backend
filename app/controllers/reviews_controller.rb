class ReviewsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]

  def index
    @reviews = Review.all
    render :index
  end

  def show
    @review = Review.find_by(id: params[:id])
    render :show
  end

  def create
    @review = Review.new(
      user_id: current_user.id,
      game_id: params["game_id"],
      review_text: params["review_text"],
      thumb_down: params["thumb_down"],
      thumb_up: params["thumb_up"],
    )
    @review.save
    if @review.valid?
      render :show
    else
      render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @review = Review.find_by(id: params["id"])
    @review.update(
      user_id: current_user.id,
      game_id: params["game_id"] || @review.game_id,
      review_text: params["review_text"] || @review.review_text,
      thumb_down: params["thumb_down"] || @review.thumb_down,
      thumb_up: params["thumb_up"] || @review.thumb_down,
    )
    if @review.valid?
      render :show
    else
      render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    review = Review.find_by(id: params["id"])
    review.delete
    render json: { message: "Review deleted." }
  end
end
