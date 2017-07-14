class SkillsController < ApplicationController
  before_action :set_skill, only: [:show, :update, :destroy]
  before_action :set_user
  # GET /skills
  def index
    @skills = Skill.all
    if(@user) then
      @skills = @user.skills
    end

    render json: @skills
  end

  # GET /skills/1
  def show
    render json: @skill
  end

  # POST /skills
  def create
    if @user then
      create_multiple_skills_for_user
      redirect_to user_skills_path
    else 
      @skill = Skill.new(skill_params)
      if @skill.save
        render json: @skill, status: :created, location: @skill
      else
        render json: @skill.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /skills/1
  def update
    if @skill.update(skill_params)
      render json: @skill
    else
      render json: @skill.errors, status: :unprocessable_entity
    end
  end

  # DELETE /skills/1
  def destroy
    @skill.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill
      @skill = Skill.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def skill_params
      params.require(:skill).permit(:name)
    end


    def create_multiple_skills_for_user
      skills = params[:tags].map do |tag|
        Skill.find_by_name(tag)
      end
      skills.each do |skill|
        @user.skills.push(skill)
      end
    end

    def set_user
      if(params[:user_id]=="me" and params[:token] == "this_is_a_stub_token") then
        @user = User.first
      else
        @user = User.find_by(id: params[:user_id])
      end
    end
end
