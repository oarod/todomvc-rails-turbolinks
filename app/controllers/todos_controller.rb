class TodosController < ApplicationController
  def index
    @todos = Todo.all
  end

  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      redirect_to todos_url
    end
  end

  private
    def todo_params
      params.require(:todo).permit(:text)
    end
end
