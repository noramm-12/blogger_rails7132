class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  # 取得當前用戶
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # 是否登入
  def logged_in?
    !!current_user
  end
end
