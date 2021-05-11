Rails.application.routes.draw do
  
  root 'home#index'

  resources :items do
    resources :packs
  end

  get 'get_price' => 'price#accept_and_return_combo'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
