# rails g mailer register_mailer
class RegisterMailer < ApplicationMailer

  default from: "hello@mitiendita.com"

  # metodo para enviar el email usa la plantilla /views/register_mailer/registration.html.erb
  def registration(user)
    @user = user
    mail :subject => 'Mandrill rides the Rails!',
         :to      => @user.email,
         :from    => 'hello@landmoda.com'
  end

end
