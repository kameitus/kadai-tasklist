class TasksController < ApplicationController
  before_action :set_task, only:[:show,:edit,:update,:destroy]
   before_action :require_user_logged_in
  
  def index
     @tasks = current_user.tasks.order(id: :desc).page(params[:page]).per(10)
     @task = current_user.tasks.build
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
      
      if @task.save
        flash[:success] = "タスクが正常に投稿されました"
        redirect_to @task
      else 
        flash.now[:danger] = "タスクが投稿されませんでした"
        render :new
      end
  end
  
  def edit
  end
  
  def update
      
      if @task.update(task_params)
        flash[:success] = "タスクは正常に更新されました"
        redirect_to @task
      else 
        flash.now[:danger] = "タスクは更新されませんでした"
        render :edit
      end
    
  end
  
  def destroy
    @task.destroy
    
    flash[:danger] = "タスクは正常に削除されました"
    redirect_to tasks_url
  end
  
  private
  
  def set_task
    @task = current_user.tasks.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content,:status)
  end
  
end
