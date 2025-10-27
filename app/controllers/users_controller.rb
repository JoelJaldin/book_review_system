class UsersController < ApplicationController
  before_action :require_admin
  before_action :set_user

  def ban
    @user.update(banned: true)
    redirect_back_with_notice('flash.notice.user_banned')
  end

  def unban
    @user.update(banned: false)
    redirect_back_with_notice('flash.notice.user_unbanned')
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def redirect_back_with_notice(notice_key)
    redirect_to request.referer || root_path, notice: t(notice_key, name: @user.name)
  end
end
