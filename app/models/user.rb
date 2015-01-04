class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, :omniauth_providers => [:google_oauth2, :facebook, :vkontakte, :twitter]
  has_many :authorizations

  def self.from_omniauth(auth, current_user)
    authorization = Authorization.where(:provider => auth.provider, :uid => auth.uid.to_s).first_or_initialize
    if authorization.user.blank?
      user = current_user.nil? ? User.where('email = ?', auth.info.email).first : current_user
      if user.blank?
        user = User.new
        user.password = Devise.friendly_token[0,10]
        auth.provider == 'twitter' ? user.email = "#{Devise.friendly_token[0,10]}@change.me" : user.email = auth.info.email
        user.save
      end
      authorization.user_id = user.id
      authorization.save
    end
    authorization.user
  end
end
