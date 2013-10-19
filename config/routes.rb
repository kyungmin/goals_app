GoalsApp::Application.routes.draw do
  resources :users do
    resources :goals
  end

  resource :session

  root to: "users#new"
  get 'signup', to: "users#new"
  get 'signin', to: "sessions#new"
  get 'signout', to: "sessions#destroy"
end
