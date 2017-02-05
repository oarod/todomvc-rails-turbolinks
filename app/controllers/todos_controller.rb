class TodosController < ApplicationController
  before_action :set_todo, only: [:update, :destroy]

  def index
    set_todos
    save_filter
  end

  def create
    if Todo.create(todo_params)
      redirect_with_filter
    end
  end

  def update
    @todo.update(todo_params)
    redirect_with_filter
  end

  def update_many
    Todo.update_all(todo_params.to_h)
    redirect_with_filter
  end

  def destroy
    if @todo.destroy
      redirect_with_filter
    end
  end

  def destroy_many
    if Todo.where(id: params[:ids]).destroy_all
      redirect_with_filter
    end
  end

  private
    def set_todo
      @todo = Todo.find(params[:id])
    end

    def set_todos
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

    def save_filter
      session[:filter] = filter_params
    end

    def redirect_with_filter
      redirect_to todos_url(filter: session[:filter])
    end

    def filter_params
      params[:filter]
    end
    helper_method :filter_params

    def todo_params
      params.require(:todo).permit(:text, :completed)
    end
end
