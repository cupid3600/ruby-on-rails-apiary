class ShootingStarsBroadcastJob < ApplicationJob
  queue_as :default

  def perform(creator_id, message)
    users = User.where.not(id: creator_id)
    users.find_each do |user|
      ShootingStarsChannel.broadcast_to user, action: message
    end
  end
end
