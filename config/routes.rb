Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :invoices do
    collection do
      post :import
      get :pending_bills
      get :collected_bills
    end
    resources  :collections
  end

  root to: 'invoices#index'
end
