Rails.application.routes.draw do
  root "applicants#index"

  resources :applicants
  resources :email_list, only: :index

  get  "/login",           to: "sessions#new",         as: :login
  post "/login",           to: "sessions#create",      as: :post_login
  get  "/logout",          to: "sessions#destroy",     as: :logout
  get  "confirm/:token",   to: "applicants#confirm",   as: :confirm
  post "subscribe/:token", to: "applicants#subscribe", as: :subscribe 
  post :send_mail,         to: "email_list#send_mail"

  match '*path', via: :all, to: 'application#redirect'
end
