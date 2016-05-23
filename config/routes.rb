Enfermera::Application.routes.draw do

  resources :cost_centers
  resources :accounts

  resources :blogs
  resources :officeaccounts
  resources :expenses
  resources :currentfees
  resources :rols
  resources :regions
  resources :offices
  resources :fees
  resources :incomes
  resources :inscriptions
  resources :wpdocuments
  resources :workplaces
  resources :previousjobs

  devise_for :users, :controllers => {:registrations => "registrations"}

  root to: "home#index"

  resources :accountancy, only: :index
  resources :summary_expenses, only: :index
  resources :news, only: :index
  resources :consignment, only: :index  
  resources :regional_manager, only: :index
  
  # post "report/export"
  resources :report do
    collection { post :export }
  end
  resources :reports, only: :index

  # get "senddiscount/index"
  # get "/senddiscount/sendemail/:id", to:  "senddiscount#sendemail"
  # get "/senddiscount/sendretrieve/:id", to:  "senddiscount#sendretrieve"
  resources :senddiscount do
    member do
      get :sendemail
      get :sendretrieve
    end
  end
  
  # get "management/index"
  resources :management, only: :index

  # get "adminspending/index"
  resources :adminspending, only: :index
  
  # get "adminconsignment/index"
  resources :adminconsignment, only: :index
  
  # get "admincolegiada/index"
  # get "admincolegiada/superintendencia"
  resources :admincolegiada, only: :index do
    collection { get :superintendencia }
  end
  
  # reseources adminworckplace only: :index
  # get "/adminworckplace/wppayregister", to: "adminworckplace#wppayregister"
  # get "/adminworckplace/wppay", to: "adminworckplace#wppay"

  
  resources :adminworckplace, only: :index do
    collection do
      get :wppayregister
      get :wppay
    end
  end

  
  # get "home/index"
  resources :home, only: :index

  # get "dashboard/index"
  resources :dashboard, only: :index
  
  # get "credential/index"
  resources :credential, only: :index
  
  # get "/incomes/feeforincome/:id", to: 'incomes#feeforincome'
  resources :incomes do
    member { get :feeforincome }
  end

  # get "/people/picture/:id", to: 'people#picture'
  # get "/people/pay/payregister/:id", to: 'people#payregister'
  # post "/people/pay/pay", to: 'people#pay'
  # get "/people/terms/:id", to: 'people#terms'
  # get "/people/termstopdf/:id", to: 'people#termsToPdf'
  resources :people do
    member do
      get :picture
      get :payregister
      post :pay
      get :terms
      get :termstopdf
    end
    collection { post :import }
  end

  # get "/workplaces/pay/payregister", to: 'workplaces#payregister'
  # post "/workplaces/pay/pay", to: 'workplaces#pay'
  resources :workplaces do
    member do
      get :payregister
      post :pay
    end
  end




  # get "/persondocuments/send/:id", to: "persondocuments#sendfile"
  resources :persondocuments do
    member do
      get :senddocument
    end
  end
  

end
