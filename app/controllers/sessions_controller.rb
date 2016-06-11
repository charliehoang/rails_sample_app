class SessionsController < ApplicationController
  def create
    if user && authenticated?
      log_in user
      remember_me? ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = "Invalid email/password combination."
      render 'new'
    end
  end

  def new
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def session_params
    params.
      require(:session).
      permit(
        :email, 
        :password,
        :remember_me)
  end

  def user
    @user ||= User.find_by(email: session_params[:email].downcase)
  end

  def authenticated?
    user.authenticate(session_params[:password])
  end

  def remember_me?
    session_params[:remember_me] == '1'
  end
end
