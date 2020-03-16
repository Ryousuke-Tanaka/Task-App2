class TasksController < ApplicationController
  before_action :set_user_id, only: [:show, :edit, :update, :destroy]
  before_action :set_current_user, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  
  def index
    @tasks = @user.tasks.order(id: "DESC") 
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = @user.tasks.build(task_params)
    if @task.save
      flash[:success] = "新規作成に成功しました。"
      redirect_to user_tasks_url @user
    else
      flash.now[:danger] = "新規作成に失敗しました。"
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @task.update_attributes(task_params)
      flash[:success] = "タスク情報を更新しました。"
      redirect_to user_tasks_url @user
    else
      flash.now[:danger] = "タスク更新に失敗しました。"
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = "タスクを削除しました。"
    redirect_to user_tasks_url @user
  end
  
  private
    
    def task_params
      params.require(:task).permit(:title, :detail, :user_id)
    end
    
    # beforeアクション
    
    def set_current_user
      @user = current_user
    end
    
    def set_user_id
      @user = User.find(params[:user_id])
    end
    
    def set_task
      @task = Task.find(params[:id])
    end
    
    # 管理権限者、または現在ログインしているユーザーを許可します。
    def admin_or_correct_user
      @user = User.find(params[:user_id]) if @user.blank?
      unless current_user?(@user) || current_user.admin?
        flash[:danger] = "編集権限がありません。"
        redirect_to(root_url)
      end
    end
end
