class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    user = User.from_omniauth(env['omniauth.auth'], current_user)
    if user.persisted?
      sign_in_and_redirect(user)
    else
      session['devise.user_attributes'] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  def failure
    super
  end


  alias_method :google_oauth2, :all
  alias_method :facebook, :all
  alias_method :vkontakte, :all
  alias_method :twitter, :all
end
