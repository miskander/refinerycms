Refinery::Core::Engine.routes.draw do
  root :to => 'pages#home', :via => :get
  post 'pages/preview'     => 'pages#preview', :as => :preview_pages
  match 'pages/*path/preview' => 'pages#preview', :as => :preview_page,  :via => [:get, :put]
  get '/pages/:id', :to => 'pages#show', :as => :page

  namespace :admin, :path => 'refinery' do
    get 'pages/*path/edit', :to => 'pages#edit'
    get 'pages/*path/children', :to => 'pages#children', :as => 'children_pages'
    get 'pages/*path/revisions', :to => 'pages#revisions', :as => 'revisions'
    put 'pages/*path', :to => 'pages#update'
    delete 'pages/*path', :to => 'pages#destroy'
    resources :pages, :except => :show do
      post :update_positions, :on => :collection
    end

    resources :pages_dialogs, :only => [] do
      collection do
        get :link_to
        get :test_url
        get :test_email
      end
    end

    resources :page_parts, :only => [:new, :create, :destroy]
  end
end
