class WelcomeController < ApplicationController
  def index
    @activity = PublicActivity::Activity.all
  end

  def music
  end
end
