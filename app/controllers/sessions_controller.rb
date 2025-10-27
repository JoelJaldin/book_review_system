class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: t('flash.notice.welcome', name: user.name)
    else
      flash.now[:alert] = t('flash.alert.invalid_credentials')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: t('flash.notice.logged_out')
  end
end

