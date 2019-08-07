Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :invoices do
    resources  :collections
  end

  root to: 'invoices#index'
end
