class OmniauthCallbacks < ApplicationController
  def facebook
    auth = request.env["omniauth.auth"]
    data = {
      name:
      surname:
      username:
      email:
      provider:
      uid:
    }
  end
end