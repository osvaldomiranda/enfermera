Enfermera::Application.routes.draw do
  get "padron/index"
  get "padron/toxls"
  get "welcome/index"
  root to: "home#index"

  resources :countries

  resources :benefits

  resources :counties

  resources :states

  resources :regional_councils

  resources :magazines

  
  resources :national_councils

  resources :scientific_societies

  resources :videos

  resources :publications do
    collection do
      post :froala_uploa
    end
  end

  resources :jobs

  resources :dailies do
    collection do
      get :toxls
    end
  end

  resources :vows 

  resources :candidates

  resources :positions

  resources :votes do
    collection do
      get :votar
    end 
  end

  resources :expenses do
    collection do
      get :toxls
    end
  end

  resources :cost_centers
  resources :accounts

  resources :blogs
  resources :officeaccounts

  resources :currentfees
  resources :rols
  resources :regions
  resources :offices
  resources :fees
  resources :inscriptions
  resources :wpdocuments
  resources :previousjobs

  devise_for :users, :controllers => {:registrations => "registrations"}

  

  resources :home, only: :index do
    collection do
      get :porque
      get :beneficios
      get :obligaciones
      get :estatutos
      get :reglamento
    end
  end

  resources :accountancy, only: :index
  resources :summary_expenses, only: :index
  resources :news, only: :index
  resources :consignment, only: :index  
  resources :regional_manager, only: :index
  
  # post "report/export"
  resources :report do
    collection { post :export }
  end
  resources :reports  do
    collection do
      get :gastos_cc
    end
    member do
      get :gastos_cta_cc
      get :detalle_diario
    end
  end

  resources :head_dailies do
    collection do
      post :create
    end  
    member do
      get :showtopdf
      get :eliminar
      get :confirmar
    end
  end

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
    collection do 
      get :superintendencia 
      get :toxls
    end
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
    collection { get :feeforincome }
  end

  # get "/people/picture/:id", to: 'people#picture'
  # get "/people/pay/payregister/:id", to: 'people#payregister'
  # post "/people/pay/pay", to: 'people#pay'
  # get "/people/terms/:id", to: 'people#terms'
  # get "/people/termstopdf/:id", to: 'people#termsToPdf'
  resources :people do
    member do
      get :picture
      get :certificado
      get :cancel
      get :payregister
      post :pay
      get :terms
      get :termstopdf
    end
    collection do
      post :import 
      post :import_update 
      post :import_update_email
      post :create_user
      post :create_fee
      post :create_head_daily
      post :create_head_daily_egreso
      post :create_daily
      get :filter
    end 
  end

  # get "/workplaces/pay/payregister", to: 'workplaces#payregister'
  # post "/workplaces/pay/pay", to: 'workplaces#pay'
  resources :workplaces do
    member do
      get :incomes
      get :payregister
      get :change_person
      post :pay
      get :topasive
    end  
  end



  # get "/persondocuments/send/:id", to: "persondocuments#sendfile"
  resources :persondocuments do
    member do
      post :senddocument
    end
  end


  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :people do
        collection do
          get :iscollegiate
        end
      end
    end
  end
  

end
