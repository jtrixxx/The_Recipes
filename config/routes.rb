Rails.application.routes.draw do
 resources :contacts
 get '/home', to: 'pages#home'
 get '/about', to: 'pages#about'
 root 'pages#home'
end
