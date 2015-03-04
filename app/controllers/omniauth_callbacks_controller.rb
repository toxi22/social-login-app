class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    binding.pry

    @omniauth = env['omniauth.auth']
    @credintial = Credential.where(provider: @omniauth.provider, uid: @omniauth.uid).first

    find_or_new_user unless current_user
    edit_social_user if current_user

    return sign_in_new_user unless @user.persisted?
    sign_in_or_redirect if @user.persisted?
  end

  def failure
    super
  end

  def edit_social_user
    return add_social unless @credintial
    return update_social unless @credintial && (current_user.id == @credintial.user_id)
    wrong_social unless @credintial && (current_user.id != @credintial.user_id)
  end

  def find_or_new_user
    return find_user if @credintial
    new_user unless @credintial
  end
  def new_user
    @user = User.new_user_from_omniauth(@omniauth)
  end

  def find_user
    @user = User.where(email: @omniauth.info.email).first
  end

  def add_social
    @user = User.bind_social_network_from_omniauth(@omniauth, current_user)
    @user.save
  end

  def update_social
    @user = User.update_social_network_from_omniauth(@omniauth, current_user)
    @user.save
  end

  def wrong_social
    flash[:alert] = t('.duplicate_social_account')
    @user = current_user
  end

  def sign_in_new_user
    @user.save
    sign_in_and_redirect(@user)
  end

  def sign_in_or_redirect
    return sign_in_and_redirect(@user) unless current_user
    redirect_to edit_user_registration_path  if current_user
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
