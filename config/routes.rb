SnakeClient::Application.routes.draw do
  devise_for :users do
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
  end

  root :to => "welcome#index"
  
  resources :users

  resources :projects do
    resources :issues
    resources :members
  end
  
  match '/dashboard' => 'dashboard#index', :as => 'user_root'
  
  resources :comments
end
