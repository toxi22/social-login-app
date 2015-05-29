module OmniAuthLogin
  extend ActiveSupport::Concern
  class_methods do
    def user_from_omniauth(auth, current_user)
      @auth = auth
      @current_user = current_user
      @user = User.new
      @current_user ? social_network_data_processing : find_or_create_user
      @user.save unless @user.persisted?
      @user
    end

    def social_network_data_processing
      if credential
        @current_user.id == credential.user_id ? update_social_network_data : wrong_social_network_data
      else
        add_social_network_data
      end
    end

    def update_social_network_data
    end

    def add_social_network_data
    end

    def wrong_social_network_data
    end

    def find_or_create_user
    end

    def credential
      @credential ||= Credential.find_by_provider_and_uid(@auth.provider,@auth.uid)
    end
    # def user_from_omniauth(auth, current_user)
    #   @omniauth = auth
    #   @credential = Credential.find_by_provider_and_uid(auth.provider, auth.uid)
    #   @current_user = current_user
    #   @current_user ? social_network_data_processing : find_or_create_user
    #   @user.save unless @user.persisted?
    #   @user
    # end
    #
    # def create_user_from_omniauth
    #   user = User.new
    #   user.password = Devise.friendly_token[0,10]
    #   @omniauth.provider == 'twitter' ? user.email = "#{Devise.friendly_token[0,10]}@example.com" : user.email = @omniauth.info.email
    #   user = User.bind_social_network_from_omniauth(@omniauth, user)
    #   user.name = user.credentials.first.name
    #   user.avatar_url = user.credentials.first.avatar_url
    #   user
    # end
    #
    # def bind_social_network_from_omniauth
    #   update_attr(@omniauth, @current_user.credentials.new(
    #                       provider: @omniauth.provider, uid: @omniauth.uid, access_token: @omniauth.credentials.token,
    #                       name: @omniauth.info.name, avatar_url: @omniauth.info.image))
    #   @current_user
    # end
    # def unbind_social_network(current_user, provider)
    #   current_user.credentials.find_by_provider(provider).destroy
    # end
    # def update_social_network_from_omniauth
    #   update_attr(@omniauth, @current_user.credentials.find_by_provider(@omniauth.provider))
    #   current_user
    # end
    #
    # def update_attr(auth, credential)
    #   credential.update_attributes(name: auth.info.name, avatar_url: auth.info.image)
    #   case
    #     when auth.provider == 'twitter'
    #       credential.update_attributes(
    #           access_token_secret: auth.credentials.secret, url: auth.info.urls.Twitter)
    #     when auth.provider == 'facebook'
    #       credential.update_attributes(
    #           expires_at: auth.credentials.expires_at, url: auth.info.urls.Facebook)
    #     when auth.provider == 'google_oauth2'
    #       credential.update_attributes(
    #           expires_at: auth.credentials.expires_at, url: "https://plus.google.com/u/0/#{auth.extra.raw_info.sub}")
    #     when auth.provider == 'vkontakte'
    #       credential.update_attributes(
    #           expires_at: auth.credentials.expires_at, url: auth.info.urls.Vkontakte)
    #   end
    # end
    # def social_network_data_processing
    #   if @credential
    #     current_user.id == @credential.user_id ? update_social_network_data : wrong_social_network_data
    #   else
    #     add_social_network_data
    #   end
    # end
    # def find_or_create_user
    #   @credential ? find_user : create_user
    # end
    # def create_user
    #   @user = User.create_user_from_omniauth
    # end
    # def find_user
    #   @user = User.find_by_email(@omniauth.info.email).take
    # end
    # def add_social_network_data
    #   @user = User.bind_social_network_from_omniauth
    #   @user.save
    # end
    # def update_social_network_data
    #   @user = User.update_social_network_from_omniauth
    #   @user.save
    # end
    # def wrong_social_network_data
    #   @user = @credential.user
    # end
  end
end