class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    @omniauth = env['omniauth.auth']
    @credential = Credential.where(provider: @omniauth.provider, uid: @omniauth.uid).first
    current_user ? social_network_data_processing : find_or_create_user
    @user.persisted? ? sign_in_or_redirect : sign_in_new_user
  end

  def failure
    super
  end

  def social_network_data_processing
    if @credential
      current_user.id == @credential.user_id ? update_social_network_data : wrong_social_network_data
    else
      add_social_network_data
    end
  end

  def find_or_create_user
    @credential ? find_user : create_user
  end

  def create_user
    @user = User.create_user_from_omniauth(@omniauth)
  end

  def find_user
    @user = User.where(email: @omniauth.info.email).first
  end

  def add_social_network_data
    @user = User.bind_social_network_from_omniauth(@omniauth, current_user)
    @user.save
  end

  def update_social_network_data
    @user = User.update_social_network_from_omniauth(@omniauth, current_user)
    @user.save
  end

  def wrong_social_network_data
    @user = @credential.user
    sign_out current_user
  end

  def sign_in_new_user
    @user.save
    sign_in @user
    redirect_to edit_user_registration_path
  end

  def sign_in_or_redirect
    current_user ? redirect_to(edit_user_registration_path) : sign_in_and_redirect(@user)
  end

  def unbind
    User.unbind_social_network(current_user, request.path_parameters[:provider])
    redirect_to edit_user_registration_path
  end

  alias_method :google_oauth2, :all
  alias_method :facebook, :all
  alias_method :vkontakte, :all
  alias_method :twitter, :all
end
