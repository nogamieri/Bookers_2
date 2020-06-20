Rails.application.routes.draw do
  
  # get 'homes/top'
  devise_for :users, controllers: {
  	sessions: 'devise/sessions',
  	registrations: 'devise/registrations'
  }
	root 'homes#top'
	get 'home/about' => 'homes#about'
	
	resources :users, only:[:show, :edit, :index, :update]
 	resources :books, only: [:create, :index, :show, :edit, :update, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end