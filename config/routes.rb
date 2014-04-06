Rails.application.routes.default_url_options[:host] = 'wiki.codeforkids.ca'

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

       #     category_pages GET      /categories/:category_id/pages(.:format)                           pages#index
       #                    POST     /categories/:category_id/pages(.:format)                           pages#create
       #  new_category_page GET      /categories/:category_id/pages/new(.:format)                       pages#new
       # edit_category_page GET      /categories/:category_id/pages/:id/edit(.:format)                  pages#edit
       #      category_page GET      /categories/:category_id/pages/:id(.:format)                       pages#show
       #                    PATCH    /categories/:category_id/pages/:id(.:format)                       pages#update
       #                    PUT      /categories/:category_id/pages/:id(.:format)                       pages#update
       #                    DELETE   /categories/:category_id/pages/:id(.:format)                       pages#destroy

       #         categories GET      /categories(.:format)                                              categories#index
       #                    POST     /categories(.:format)                                              categories#create
       #       new_category GET      /categories/new(.:format)                                          categories#new
       #      edit_category GET      /categories/:id/edit(.:format)                                     categories#edit
       #           category GET      /categories/:id(.:format)                                          categories#show
       #                    PATCH    /categories/:id(.:format)                                          categories#update
       #                    PUT      /categories/:id(.:format)                                          categories#update
       #                    DELETE   /categories/:id(.:format)                                          categories#destroy

  controller :categories do
    post     'category' => :create, :as => :create_category
    get      'category/new' => :new, :as => :new_category
    get      'category/:handle/edit' => :edit, :as => :edit_category
    get      'category/:handle' => :show, :as => :show_category
    patch    'category/:id' => :update
    put      'category/:id' => :update, :as => :update_category
    delete   'category/:handle' => :destroy, :as => :delete_category


    controller :pages do
       post     'pages' => :create, :as => :create_page
       get      'category/:handle/pages/new' => :new, :as => :new_page
       get      'pages/:id/edit' => :edit, :as => :edit_page
       get      'category/:handle/pages/:page_handle' => :show, :as => :page
       patch    'pages/:id' => :update
       put      'pages/:id' => :update, :as => :update_page
       delete   'category/:handle/pages/:page_handle' => :destroy, :as => :delete_page


      controller :commits do
        get 'category/:handle/pages/:page_handle/commits' => :index, :as => :page_commits
      end
    end
  end

end
