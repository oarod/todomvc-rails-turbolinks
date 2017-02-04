class TodosController < ApplicationController
  before_action :set_todo, only: [:update, :destroy]

  def index
    @todos =
      case filter_params
      when 'active'
        Todo.where(completed: false)
      when 'completed'
        Todo.where(completed: true)
      else
        Todo.all
      end
  end

  def create
    if Todo.create(todo_params)
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

    def filter_params
      params[:filter]
    end
    helper_method :filter_params

    def todo_params
      params.require(:todo).permit(:text, :completed)
    end
end
