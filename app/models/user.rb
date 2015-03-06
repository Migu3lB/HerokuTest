class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, allow_blank: true

  has_many :sells

  #For Carrierwave
  mount_uploader :avatar, AvatarUploader

  after_create :send_email

  def self.create_with_ommiauth(auth)
    self.create! do |user|
    user.provider = auth['provider']
    user.uid = auth['uid']
    user.name = auth['info']['name']
    user.token = auth['credentials']['name']
    user.secret = auth['credentials']['secret']
    user.url_photo = auth['info']['image']
    end
  end 

end

  def login
    User.where(email: self.email, password: self.password).first
  end

  #callback for sending the email
  def send_email
    # RegisterMailer.registration(self).deliver_now
    SendEmailJob.set(wait: 20.seconds).perform_later(self)
  end
