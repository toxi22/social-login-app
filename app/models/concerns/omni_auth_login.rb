module OmniAuthLogin
  extend ActiveSupport::Concern
  class_methods do
    def create_user_from_omniauth(auth)
      user = User.new
      user.password = Devise.friendly_token[0,10]
      auth.provider == 'twitter' ? user.email = "#{Devise.friendly_token[0,10]}@change.me" : user.email = auth.info.email
      user = User.bind_social_network_from_omniauth(auth, user)
      user.name = user.credentials.first.name
      user.avatar_url = user.credentials.first.avatar_url
      user
    end

    def bind_social_network_from_omniauth(auth, current_user)
      credential = current_user.credentials.new(provider: auth.provider, uid: auth.uid, access_token: auth.credentials.token,
                                                name: auth.info.name, avatar_url: auth.info.image)
      case
        when auth.provider == 'twitter'
          credential.update_attributes(access_token_secret: auth.credentials.secret, url: auth.info.urls.Twitter)
        when auth.provider == 'facebook'
          credential.update_attributes(expires_at: auth.credentials.expires_at, url: auth.info.urls.Facebook)
        when auth.provider == 'google_oauth2'
          credential.update_attributes(expires_at: auth.credentials.expires_at, url: "https://plus.google.com/u/0/#{auth.extra.raw_info.sub}")
        when auth.provider == 'vkontakte'
          credential.update_attributes(expires_at: auth.credentials.expires_at, url: auth.info.urls.Vkontakte)
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