Enfermera::Application.routes.draw do
  

  
  resources :currentfees

  resources :rols

  resources :regions

  get "sensomatica/index"
  get "sensomatica/calltemp"
  resources :offices

  resources :fees

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

  post "report/export"
  get "senddiscount/index"
  get "/senddiscount/sendemail/:id", to:  "senddiscount#sendemail"
  get "/senddiscount/sendretrieve/:id", to:  "senddiscount#sendretrieve"
  get "management/index"
  get "adminspending/index"
  get "adminconsignment/index"
  get "admincolegiada/index"
  get "admincolegiada/superintendencia"
  get "adminworckplace/index"
  get "/adminworckplace/wppayregister", to: "adminworckplace#wppayregister"
  get "/adminworckplace/wppay", to: "adminworckplace#wppay"
  get "home/index"
  get "dashboard/index"
  get "credential/index"
  get "/incomes/feeforincome/:id", to: 'incomes#feeforincome'

  get "/people/picture/:id", to: 'people#picture'
  get "/people/pay/payregister/:id", to: 'people#payregister'
  post "/people/pay/pay", to: 'people#pay'

  get "/workplaces/pay/payregister", to: 'workplaces#payregister'
  post "/workplaces/pay/pay", to: 'workplaces#pay'

  get "/people/terms/:id", to: 'people#terms'
  get "/people/termstopdf/:id", to: 'people#termsToPdf'
  get "/persondocuments/send/:id", to: "persondocuments#sendfile"
  # devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}
  

end
