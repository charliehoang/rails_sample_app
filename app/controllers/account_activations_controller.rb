class AccountActivationsController < ApplicationController
  def edit
    if activate_user?
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end

  private

  def user
    User.find_by(email: params[:email])
  end

  def activate_user?
    user && !user.activated? && user.authenticated?(:activation, params[:id])
  end
end
