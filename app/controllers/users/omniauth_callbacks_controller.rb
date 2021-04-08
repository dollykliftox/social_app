# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      @provider = User.from_omniauth(request.env['omniauth.auth'])
      if @provider.persisted?
        sign_in_and_redirect @provider.user, event: :authentication
        set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
      else
        session['devise.facebook_data'] = request.env['omniauth.auth']
        redirect_to new_user_registration_url
      end
    end

    def google_oauth2
      @provider = User.from_omniauth(request.env['omniauth.auth'])
      if @provider.persisted?
        sign_in_and_redirect @provider.user, event: :authentication
        set_flash_message(:notice, :success, kind: 'google') if is_navigational_format?
      else
        # session['devise.google_oauth2_data'] = request.env['omniauth.auth']
        redirect_to new_user_registration_url
      end
    end

    def failure
      redirect_to root_path
    end
  end
end
