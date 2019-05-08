class AdminMailer < ApplicationMailer
  def daily_email(admin)
    @admin = admin
    mail(to: @admin.email, subject: 'Daily Flagged Contents')
  end

  def new_constellation_request(constellation_request)
    admins = AdminUser.pluck :email
    @constellation_request = constellation_request

    mail(to: admins, subject: 'A new constellation was requested')
  end
end
