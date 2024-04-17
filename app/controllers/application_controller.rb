class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  # 取得當前用戶
  def current_user
    #check @current_user是否有值
    # 如果沒有值 檢查session[:user_id] 是否存在
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # 是否登入
  def logged_in?
    !!current_user
  end

  #需要登入
  def require_user
    if !logged_in?
      flash[:alert]="You must be logged in to perform that action"
      redirect_to login_path
    end
  end
end
