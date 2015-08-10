#encoding: utf-8

class Invite < ApplicationMailer

  def invite(addr, token)
    @email = addr
    @url = "http://localhost:3000/new_applicant/#{token}"
    mail(to: @email, subject: "Você foi convidado para o evento.")
  end

end
