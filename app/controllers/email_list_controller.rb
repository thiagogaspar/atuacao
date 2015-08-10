class EmailListController < ApplicationController
  require 'csv'

  def index

  end

  def send_mail
    parse_csv(params[:mail_file].tempfile).each do |addr|
      @attendee = Applicant.new(email: addr, confirmation_token: create_token(addr))

      if @attendee.save
        Invite.invite(addr, @attendee.confirmation_token).deliver_now
      end
    end

    render nothing: true
  end

  private

  def parse_csv(temp_file)
    emails = Array.new 

    CSV.foreach(temp_file) do |address|
      emails << address
    end

    emails.flatten
  end


  def create_token(addr)
    message_payload = "#{addr}_#{Time.now.utc}_#{rand(1000000).to_s(36)}"
    Digest::SHA1.hexdigest(message_payload)
  end
end
