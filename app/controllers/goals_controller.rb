class GoalsController < ApplicationController
  def index
    @goals = Goal.where(user_id: current_user.id)
    render :index
  end

  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = Goal.new(params[:goal])
    @goal.user_id = params[:user_id]
    if @goal.save
      flash[:notice] = ["Goal successfully created!"]
      redirect_to user_goal_url(@goal.user, @goal)
    else
      flash[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @goal = Goal.find(params[:id])
    render :show
  end

  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update_attributes(params[:goal])
    flash[:notice] = ["Goal updated."]
      redirect_to user_goal_url(@goal)
    else
      flash[:errors] = @goal.errors.full_messages
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.delete
    flash[:notice] = ["Goal deleted."]
    redirect_to user_goals_url(@goal.user)
  end
end
