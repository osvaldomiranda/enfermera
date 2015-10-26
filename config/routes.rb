Hikerdata::Application.routes.draw do
  get "summary/index"
  root to: "home#index"
  get "home/index"

  get "dashboard/index"
  get "summary/pdf_me/:id", to: 'summary#pdf_me'
  get "summary/csv_me/:id", to: 'summary#csv_me'

  get "/people/picture/:id", to: 'people#picture'
  # devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}
  devise_for :users, :controllers => {:registrations => "registrations"}


  resources :documents
  resources :direccions
  resources :vehiculos
  resources :bienes_raices
  resources :ingresos
  resources :deuda_indirecta
  resources :deuda_directa
  resources :sociedads
  resources :jubilados
  resources :universitarios
  resources :dependents
  resources :independents
  resources :spouses

  resources :people do
    collection { post :import }
  end

end
