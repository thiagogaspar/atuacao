#encoding: utf-8

class Invite < ApplicationMailer

  def invite(addr, token)
    @email = addr
    @url = url_for(controller: :applicants, 
                   action: :confirm, 
                   token: token)
    mail(to: @email, subject: "Você foi convidado para o evento.")
  end

end
