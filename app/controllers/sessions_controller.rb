class SessionsController < ApplicationController
  def new
  	render :new
  end

  def create
  	@user = User.find_by_credentials(params[:user][:email], params[:user][:password])
  	if @user
  		login_user!(@user)
  		flash[:notice] = ["Logged in successfully."]
  		redirect_to user_url(@user)
  	else
  		flash[:errors] = ["Invalid login credentials"]
  		render :new
  	end
  end

  def destroy
  	logout_user!
  	flash[:notice] = ["You are now logged out."]
  	redirect_to signin_url
  end
end
