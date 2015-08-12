Rails.application.routes.draw do
  root "applicants#index"

  resources :applicants, except: :new
  resources :email_list, only: :index

  get  "/login",  to: "sessions#new"
  post "/login",  to: "sessions#create"
  get  "/logout", to: "sessions#destroy"
  get "new_applicant/:token", to: "applicants#new"
  post :send_mail, to: "email_list#send_mail"
end
