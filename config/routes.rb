Enfermera::Application.routes.draw do
  resources :inscriptions

  resources :wpdocuments

  resources :persondocuments

  resources :workplaces

  resources :previousjobs

  root to: "home#index"

  get "home/index"
  get "dashboard/index"
  get "credential/index"

  get "/people/picture/:id", to: 'people#picture'
  get "/people/terms/:id", to: 'people#terms'
  get "/people/termstopdf/:id", to: 'people#termsToPdf'
  get "/persondocuments/send/:id", to: "persondocuments#sendfile"
  # devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}
  
  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :people do
    collection { post :import }
  end

end
