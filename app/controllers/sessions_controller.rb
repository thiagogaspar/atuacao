class SessionsController < ApplicationController
  
  def new
  end

  def create
    @user = User.find_by name: params[:name]
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to applicants_path, notice: "Login realizado com sucesso."
    else
      redirect_to login_url, notice: "Verifique seu nome e senha."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, notice: "Logout realizado com sucesso."
  end
end
