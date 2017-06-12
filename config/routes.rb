Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # namespace the controllers without affecting the URI
  scope module: :v1, constraints: ApiVersion.new('v1', true) do

  end

  resources :posts
  resources :users

  post 'signup', to: 'users#create'
  post 'auth/login', to: 'authentication#authenticate'

end
