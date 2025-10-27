class UsersController < ApplicationController
  def ban
    @user = User.find(params[:id])
    @user.update(banned: true)
    redirect_to request.referer || root_path, notice: "Usuario #{@user.name} ha sido baneado exitosamente."
  end

  def unban
    @user = User.find(params[:id])
    @user.update(banned: false)
    redirect_to request.referer || root_path, notice: "Usuario #{@user.name} ha sido desbaneado exitosamente."
  end
end
