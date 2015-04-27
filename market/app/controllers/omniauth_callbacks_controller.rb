class OmniauthCallbacksController < ApplicationController
  def facebook
    auth = request.env["omniauth.auth"]
    data = {
      name: auth.info.first_name,
      surname: auth.info.last_name,
      username: auth.info.nickname,
      email: auth.info.email,
      provider: auth.provider,
      uid: auth.uid
    }
    @user = User.find_or_create_by_omniauth(data)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication

    else
      session[:omniauth_errors] = @user.errors.full_messages.to_sentence unless @user.save

      session[:omniauth_data] = data

      redirect_to new_usuario_registration_url
    end
  end
  def twitter
    auth = request.env["omniauth.auth"]
    data = {
      nombre: auth.info.name,
      surname: "",
      username: auth.info.nickname,
      email: "",
      provider: auth.provider,
      uid: auth.uid
    }

    @user = User.find_or_create_by_omniauth(data)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      session[:omniauth_errors] = @user.errors.full_messages.to_sentence unless @user.save

      session[:omniauth_data] = data

      redirect_to new_user_registration_url
    end
  end

end
