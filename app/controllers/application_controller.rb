class ApplicationController < ActionController::Base
  before_action :verify_authenticity_token

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    flash[:alert] = t('flash.alert.record_not_found')
    redirect_to root_path
  end

  def require_admin
    redirect_to root_path, alert: t('flash.alert.no_permission') unless current_user&.admin?
  end

  # Autorización: verifica que el usuario esté autenticado
  def require_login
    unless current_user
      redirect_to new_session_path, alert: t('flash.alert.login_required')
    end
  end

  # Método helper: obtiene el usuario actual desde la sesión
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil
    nil
  end
  helper_method :current_user
end
