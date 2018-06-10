class UsersWorker
  include Sidekiq::Worker
  def perform(user_id, token)
    @user = User.find_by id: user_id
    UserMailer.account_activation(@user, token).deliver_now
  end
end
