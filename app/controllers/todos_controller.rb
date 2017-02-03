class TodosController < ApplicationController
  before_action :set_todo, only: [:update, :destroy]

  def index
    @todos = Todo.all
  end

  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      redirect_to todos_url
    end
  end

  def update
    if @todo.update(todo_params)
      redirect_to todos_url
    end
  end

  def update_many
    if Todo.update_all(todo_params.to_h)
      redirect_to todos_url
    end
  end

  def destroy
    if @todo.destroy
      redirect_to todos_url
    end
  end

  def destroy_many
    if Todo.where(id: params[:ids]).destroy_all
      redirect_to todos_url
    end
  end

  private
    def set_todo
      @todo = Todo.find(params[:id])
    end

    def todo_params
      params.require(:todo).permit(:text, :completed)
    end
end
