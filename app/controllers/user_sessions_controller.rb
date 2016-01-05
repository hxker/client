class UserSessionsController < ApplicationController
  before_filter :login_required, only: [:destroy]


  # omniauth callback method
  #
  # First the callback operation is done
  # inside OmniAuth and then this route is called
  def create
    omniauth = env['omniauth.auth']
    logger.debug "log--begin#{omniauth}--end"

    user = User.find_by_uid(omniauth['uid'])
    if not user
      # New user registration
      user = User.new(:uid => omniauth['uid'])
    end
    user.email = omniauth['info']['email']
    user.save

    #p omniauth

    # Currently storing all the info
    session[:user_id] = omniauth

    flash[:notice] = "登录成功"
    redirect_to root_path
  end

  # Omniauth failure callback
  def failure
    flash[:notice] = params[:message]
  end

  # logout - Clear our rack session BUT essentially redirect to the provider
  # to clean up the Devise session from there too !
  def destroy
    session[:user_id] = nil

    flash[:notice] = '您已经成功退出!'
    redirect_to "#{CUSTOM_PROVIDER_URL}/users/sign_out?return_url=http://localhost:3001"
  end
end
