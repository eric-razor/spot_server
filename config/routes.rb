Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  namespace :api do
    namespace :v1 do 
      get '/login', to: 'login#create'
      post '/token', to: 'user#create'
      
      
      resources :users

    end
  end

end
