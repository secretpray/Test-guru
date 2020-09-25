Rails.application.routes.draw do

  root to: 'tests#index'

  resources :tests do
    resources :questions, shallow: true
  end

  get '/questions/:id/destroy', to: 'questions#destroy'

  # resources :tests, only: %i[] do
  #   resources :questions, shallow: true, except: %i[edit update]
  # end

  # resources :categories do
  #   resources :tests, shallow: true do
  #     resources :questions, shallow: true do
  #       resources :answers, shallow: true
  #     end
  #   end
  # end

  # get 'tests/:id/start', to: 'tests#start'
  # get 'tests/:id/start', to: 'task#start'
  # Class: ActionController::Parameters
  # Parameters: <ActionController::Parameters {"controller"=>"tests", "action"=>"search", "category"=>"backend", "title"=>"Rails"} permitted: false>
  # get 'tests/backend/Rails'
  # get 'tests/:category/:title', to: 'tests#search' #, level: 2 значение по умолчанию, оно перекрывает запросы из адресной строки
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
