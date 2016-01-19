Enfermera::Application.routes.draw do
  

  resources :fees

  get "senddiscount/index"
  resources :incomes

  resources :inscriptions

  resources :wpdocuments

  resources :persondocuments

  resources :workplaces

  resources :previousjobs

  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :people do
    collection { post :import }
  end


  root to: "home#index"

  get "senddiscount/index"
  get "senddiscount/sendemail"
  get "management/index"
  get "adminspending/index"
  get "adminconsignment/index"
  get "admincolegiada/index"
  get "adminworckplace/index"
  get "/adminworckplace/wppayregister", to: "adminworckplace#wppayregister"
  post "/adminworckplace/wppay", to: "adminworckplace#wppay"
  get "home/index"
  get "dashboard/index"
  get "credential/index"

  get "/people/picture/:id", to: 'people#picture'
  get "/people/pay/payregister", to: 'people#payregister'
  post "/people/pay/pay", to: 'people#pay'

  get "/people/terms/:id", to: 'people#terms'
  get "/people/termstopdf/:id", to: 'people#termsToPdf'
  get "/persondocuments/send/:id", to: "persondocuments#sendfile"
  # devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}
  

end
