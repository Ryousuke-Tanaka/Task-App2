class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
   # paramsハッシュからユーザーを取得します。
    def set_user
      @user = User.find(params[:id])
    end
  
  # ログイン済みのユーザーか確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end
    
  # アクセスしたユーザーが現在ログインしているユーザーか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end
  
  # システム管理権限所有かどうか判定します。
    def admin_user
      redirect_to root_url unless current_user.admin? # falseであればroot_urlへリダイレクト
    end
end
