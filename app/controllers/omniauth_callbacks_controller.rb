class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    auth = env['omniauth.auth']
    user = User.user_from_omniauth(auth, current_user)
    sign_out current_user if current_user
    sign_in user
    redirect_to edit_user_registration_path
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
