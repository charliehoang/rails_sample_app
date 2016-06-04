module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Forgets a persistent session
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Returns the current logged-in user (if any).
  def current_user
    if session_user
      @current_user ||= session_user
    elsif cookie_user
      log_in cookie_user
      @current_user ||= cookie_user
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  private

  # Returns user for temp session
  def session_user
    User.find_by(id: session[:user_id])
  end

  # Returns user for persistent cookie
  def cookie_user
    user = User.find_by(id: cookies.signed[:user_id])
    user if user && user.authenticated?(cookies[:remember_token])
  end
end