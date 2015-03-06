#rails g job send_email
#rails generate delayed_job:active_record
#rake db:migrate
class SendEmailJob < ActiveJob::Base
  queue_as :default

  def perform(user)
    RegisterMailer.registration(user).deliver_later
  end
end
