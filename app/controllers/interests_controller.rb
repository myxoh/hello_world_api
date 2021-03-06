class InterestsController < ApplicationController
  before_action :set_interest, only: [:show, :update, :destroy]
  before_action :set_user

  # GET /interests
  def index
    @interests = Interest.all
    if(@user) then
      @interests=@user.interests
    end

    render json: @interests
  end

  # GET /interests/1
  def show
    render json: @interest
  end

  # POST /interests
  def create
    if @user then
      create_multiple_interests_for_user
      redirect_to user_interests_path
    else 
      @interest = Interest.new(interest_params)

      if @interest.save
        render json: @interest, status: :created, location: @interest
      else
        render json: @interest.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /interests/1
  def update
    if @interest.update(interest_params)
      render json: @interest
    else
      render json: @interest.errors, status: :unprocessable_entity
    end
  end

  # DELETE /interests/1
  def destroy
    @interest.destroy
  end

  private
    def create_multiple_interests_for_user
      interests = params[:tags].map do |tag|
        Interest.find_by_name(tag)
      end
      interests.each do |interest|
        @user.interests.push(interest)
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_interest
      @interest = Interest.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def interest_params
      params.require(:interest).permit(:name)
    end

    def set_user
      if(params[:user_id]=="me" and params[:token] == "this_is_a_stub_token") then
        @user = User.first
      else
        @user = User.find_by(id: params[:user_id])
      end
    end
end
