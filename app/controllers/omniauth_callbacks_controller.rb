class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    binding.pry
    credintial = Credential.where(provider: env['omniauth.auth'].provider, uid: env['omniauth.auth'].uid).first
    if current_user.nil?
      if credintial.nil?
        user = User.new_user_from_omniauth(env['omniauth.auth'])
      else
        user = User.where(email: env['omniauth.auth'].info.email).first
      end
    else
      if credintial.nil?
        user = User.bind_social_network_from_omniauth(env['omniauth.auth'], current_user)
        user.save
      else
        if current_user.id == credintial.user_id
          user = User.update_social_network_from_omniauth(env['omniauth.auth'], current_user)
          user.save
        else
          # TODO Generate error
          user = current_user
        end
      end
    end

    if user.persisted?
      if current_user.nil?
        sign_in_and_redirect(user)
      else
        sign_in user
        redirect_to edit_user_registration_path
      end
    else
      user.save
      sign_in user
      redirect_to edit_user_registration_path
    end
  end

  def failure
    super
  end

  def unbind
    User.unbind_social_network(current_user, request.path_parameters[:provider])
    redirect_to edit_user_registration_path
  end

  alias_method :google_oauth2, :all
  alias_method :facebook, :all
  alias_method :vkontakte, :all
  alias_method :twitter, :all
  alias_method :passthru, :all
end
