Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  root 'categories#index'
  get '/logout' => 'application#logout'
  get 'ping' => 'application#ping'

  # resources :pages

  # controller :pages do
  #   get '/pages/new' => :new, :as => :create_page
  #   post '/pages/create' => :create
  #   get '/pages/:category' => :category
  #   get '/pages/:category/:id' => :show, :as => :page
  #   get '/pages/:category/:id/edit' => :edit, :as => :edit_page
  #   patch '/pages/:category/:id/update' => :update, :as => :update_page
  #   get 'pages/:category/:id/history' => :history
  # end

  resources :categories do
    resources :pages
  end

end
