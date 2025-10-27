require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  describe "PATCH /users/:id/ban" do
    it "bans a user successfully" do
      expect {
        patch "/users/#{user.id}/ban"
      }.to change { user.reload.banned }.from(false).to(true)
    end

    it "does not ban already banned user" do
      user.update(banned: true)
      expect {
        patch "/users/#{user.id}/ban"
      }.not_to change { user.reload.banned }
    end
  end

  describe "PATCH /users/:id/unban" do
    let(:banned_user) { create(:user, banned: true) }

    it "unbans a user successfully" do
      expect {
        patch "/users/#{banned_user.id}/unban"
      }.to change { banned_user.reload.banned }.from(true).to(false)
    end

    it "does not unban already active user" do
      expect {
        patch "/users/#{user.id}/unban"
      }.not_to change { user.reload.banned }
    end
  end
end
