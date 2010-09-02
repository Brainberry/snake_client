SnakeClient::Application.routes.draw do
  devise_for :users do
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
  end

  root :to => "welcome#index"

  resources :projects do
    resources :issues
    resources :members
  end
  
  resources :comments
end
