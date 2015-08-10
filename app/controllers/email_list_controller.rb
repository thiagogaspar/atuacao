class EmailListController < ApplicationController
  require 'csv'

  def index

  end

  def send_mail
    emails = Array.new
    
    CSV.foreach(params[:mail_file].tempfile) do |address|
      emails << address
    end
   
    emails.flatten!
    
    render nothing: true
  end
end
