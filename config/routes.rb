Rails.application.routes.draw do
  root 'projects#index'
  resources :projects do
    get :users, on: :member
    get '/users/new' => 'projects#new_user', on: :member,as: :new_user_to
    post '/users/assign' => 'projects#assign_user', on: :member,as: :assign_user_to

    resources :bugs do
      get :users, on: :member
      get '/new-developer' => 'bugs#new_user', on: :member,as: :new_user_to
      post '/assign-developer' => 'bugs#assign_user', on: :member,as: :assign_user_to
    end
  end
  devise_for :users #, path:"",path_names:{sign_up:'register',sign_in:'login',sign_out:'logout'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
