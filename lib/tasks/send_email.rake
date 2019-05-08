task send_admin_email: :environment do
  AdminUser.find_each do |admin|
    AdminMailer.daily_email(admin).deliver_later
  end
end
