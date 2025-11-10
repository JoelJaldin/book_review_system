class UsersController < ApplicationController
  before_action :require_admin
  before_action :set_user
  # validar que un admin no se pueda banear a sí mismo
  before_action :check_cannot_ban_self, only: [:ban]

  def ban
    # Refactorización: validar que el usuario no esté ya baneado
    if @user.banned?
      redirect_back_with_alert('flash.alert.user_already_banned')
    else
      @user.update(banned: true)
      redirect_back_with_notice('flash.notice.user_banned')
    end
  end

  def unban
    # Refactorización: validar que el usuario esté baneado antes de desbanearlo
    if @user.banned?
      @user.update(banned: false)
      redirect_back_with_notice('flash.notice.user_unbanned')
    else
      redirect_back_with_alert('flash.alert.user_not_banned')
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def check_cannot_ban_self
    if @user == current_user
      redirect_back_with_alert('flash.alert.cannot_ban_self')
    end
  end

  def redirect_back_with_notice(notice_key)
    redirect_to request.referer || root_path, 
                notice: t(notice_key, name: @user.name)
  end

  def redirect_back_with_alert(alert_key)
    redirect_to request.referer || root_path, 
                alert: t(alert_key, name: @user.name)
  end
end
