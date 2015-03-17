module OmniAuthLogin
  extend ActiveSupport::Concern
  class_methods do
    def create_user_from_omniauth(auth)
      user = User.new
      user.password = Devise.friendly_token[0,10]
      auth.provider == 'twitter' ? user.email = "#{Devise.friendly_token[0,10]}@change.me" : user.email = auth.info.email
      user = User.bind_social_network_from_omniauth(auth, user)
      # FIXME Panic
      user
    end

    def bind_social_network_from_omniauth(auth, current_user)
      if auth.provider == 'twitter'
        current_user.credentials.new(provider: auth.provider, uid: auth.uid, access_token_secret: auth.credentials.secret, access_token: auth.credentials.token)
      else
        current_user.credentials.new(provider: auth.provider, uid: auth.uid, expires_at: auth.credentials.expires_at, access_token: auth.credentials.token)
      end
      current_user
    end

    def unbind_social_network(current_user, provider)
      current_user.credentials.where(provider: provider).first.destroy
    end

    def update_social_network_from_omniauth(auth, current_user)
      current_user.credentials.where(provider: auth.provider).first.update_attributes(expires_at: auth.credentials.expires_at, access_token: auth.credentials.token) unless auth.provider == 'twitter'
      current_user
    end
  end
end