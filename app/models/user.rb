class User < ActiveRecord::Base
  include OmniAuthLogin
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: %i(google_oauth2 facebook vkontakte twitter)
  has_many :credentials, dependent: :destroy
  validates :email, uniqueness: true
end
