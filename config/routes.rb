Enfermera::Application.routes.draw do

  resources :wpemails

  resources :user_alow_votes

  resources :user_votes

  resources :wpdiscounts

  get "infoperson/creados"
  get "infoperson/modificados"
  get "daily_vpo/index"
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

  resources :vows do 
    member do
      get :showtopdf
    end  
  end    

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
  resources :accounts do
    collection do
      get :mayor
    end  
  end

  resources :blogs
  resources :officeaccounts

  resources :currentfees
  resources :rols
  resources :regions
  
  resources :fees
  resources :wpdocuments
  resources :previousjobs

  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :offices do
    collection do
      get :totalfees
    end
  end

  resources :home, only: :index do
    collection do
      get :porque
      get :beneficios
      get :obligaciones
      get :estatutos
      get :reglamento
      get :vademecum
    end
  end

  resources :inscriptions do
    collection do
      get :change_state
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
      get :guardar
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
      get :people
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
  resources :dashboard do 
    collection do
      get :index
      get :fees
    end
   
  end   
  
  # get "credential/index"
  resources :credential, only: :index
  
  # get "/incomes/feeforincome/:id", to: 'incomes#feeforincome'
  resources :incomes do
    collection do
      get :feeforincome 
      get :feeforincometoxls 
    end  
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
      get :incomplete_fee
      post :incomplete_pay
      get :error_pay
      get :terms
      get :termstopdf
      post :resetpass
    end
    collection do
      post :import 
      post :import_wpemail 
      post :import_wpemailss 
      post :import_update 
      post :import_update_email
      post :create_user
      post :create_fee
      post :create_head_daily
      post :create_head_daily_egreso
      post :create_daily
      get :filter
      get :enviar
      get :toxls
      get :continuity
      get :continuity2
      get :continuity_toxls
    end 
  end

  resources :incomplete_pay do
    member do
      post :index
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
      get :error_pay
      get :topasive
      get :todeceased
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

      resources :inscriptions do
        collection do
          get :change_state
        end
      end

      resources :fee do
        collection do
          get :update_mescuota
        end
      end
    end
  end
  

end
