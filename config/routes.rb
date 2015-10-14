Hikerdata::Application.routes.draw do
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

  resources :people

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}
  root to: "home#index"
  get "home/index"
end
