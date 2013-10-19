class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
  	@user = User.new
  	render :new
  end

  def create
  	@user = User.create(params[:user])
  	if @user.save
  		login_user!(@user)
  		flash[:notice] = ["User successfully created."]
#      msg = UserMailer.registration_email(@user)
#      p msg
#      msg.deliver!
  		redirect_to user_url(@user)
  	else
      flash[:errors] = @user.errors.full_messages
  		render :new
  	end
  end

  def show
  	@user = User.find(params[:id])
  	render :show
  end

end
