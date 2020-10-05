Rails.application.routes.draw do

  root 'pages#index'
  # get '/', :to => redirect('about.html')
  # root 'tests#index'

  get 'sessions/new'
  get 'users/new'

  get :signup, to: 'users#new'
  get :login, to: 'sessions#new'
  delete :logout, to: 'sessions#destroy'

  resources :users, only: :create
  resources :sessions, only: :create

  resources :tests do
    resources :questions, except: :index, shallow: true do
      resources :answers, except: :index, shallow: true
    end

    member do
      post :start
    end
  end

  get 'questions', to: 'tests#index'
  get 'answers', to: 'tests#index'


  resources :test_passages, only: %i[show update] do
    member do
      get :result
    end
  end

end
