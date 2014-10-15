Rails.application.routes.default_url_options[:host] = ENV['DEFAULT_HOST']

Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  root 'categories#index'
  get '/logout' => 'application#logout'
  get 'ping' => 'application#ping'
  post '/tinymce_assets' => 'tinymce_assets#create'

  resources :redirects

  controller :categories do
    post     'category' => :create, :as => :create_category
    get      'category/new' => :new, :as => :new_category
    get      'category/:handle/edit' => :edit, :as => :edit_category
    get      'category/:handle' => :show, :as => :show_category
    patch    'category/:id' => :update
    put      'category/:id' => :update, :as => :update_category
    delete   'category/:handle' => :destroy, :as => :delete_category

    controller :pages do
     get      'search' => :search, :as => :search
     post     'pages' => :create, :as => :create_page
     get      'most_recent' => :most_recent, as: :most_recent
     get      'category/:handle/pages/new' => :new, :as => :new_page
     get      'category/:handle/pages/:id/edit' => :edit, :as => :edit_page
     get      'category/:handle/pages/:page_handle' => :show, :as => :page
     patch    'pages/:id' => :update
     put      'pages/:id' => :update, :as => :update_page
     delete   'category/:handle/pages/:page_handle' => :destroy, :as => :delete_page
     post     'pages/:id/helped' => :helped, :as => :help_page

      controller :commits do
       get 'category/:handle/pages/:page_handle/commits' => :index, :as => :page_commits
      end
    end
  end

end
