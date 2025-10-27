class ApplicationController < ActionController::Base
  # Habilitar turbo
  before_action :verify_authenticity_token

  # Manejo de errores
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    flash[:alert] = "El registro solicitado no existe."
    redirect_to root_path
  end

end
