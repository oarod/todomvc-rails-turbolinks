Rails.application.routes.draw do
  root to: 'todos#index'

  resources :todos, path: '', only: [:index, :create, :update, :destroy] do
    collection do
      patch :update_many
      delete :destroy_many
      get '(:filter)', to: 'todos#index', as: :filtered
    end
  end
end
