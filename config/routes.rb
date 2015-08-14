Rails.application.routes.draw do
  root "applicants#index"

  resources :applicants, except: :new
  resources :email_list, only: :index

  get  "/login",  to: "sessions#new", as: :login
  post "/login",  to: "sessions#create", as: :post_login
  get  "/logout", to: "sessions#destroy", as: :logout
  get "new_applicant/:token", to: "applicants#new", as: :new_applicant
  post :send_mail, to: "email_list#send_mail"
end
