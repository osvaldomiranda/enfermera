Enfermera::Application.routes.draw do
  resources :inscriptions

  resources :wpdocuments

  resources :persondocuments

  resources :workplaces

  resources :previousjobs

  get "summary/index"
  root to: "home#index"
  get "home/index"

  get "dashboard/index"
  get "summary/pdf_me/:id", to: 'summary#pdf_me'
  get "summary/csv_me/:id", to: 'summary#csv_me'

  get "/people/picture/:id", to: 'people#picture'
  get "/people/terms/:id", to: 'people#terms'
  get "/people/termstopdf/:id", to: 'people#termsToPdf'
  # devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}
  devise_for :users, :controllers => {:registrations => "registrations"}




  resources :people do
    collection { post :import }
  end

end
