class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = current_user.tasks.order(id: :desc)
  end

  def show
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクは正常に投稿されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'タスクは投稿されませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy

    flash[:success] = 'タスクは正常に削除されました'
    redirect_to tasks_url
  end
  
  private

  #Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status, :id)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to "/"
    end
  end
end