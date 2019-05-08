class UserMailer < ApplicationMailer
  def accepted_constellation(constellation_request)
    @constellation_request = constellation_request
    @user = constellation_request.user

    mail(to: @user.email, subject: 'Your constellation has been accepted')
  end

  def rejected_constellation(constellation_request)
    @constellation_request = constellation_request
    @user = constellation_request.user

    mail(to: @user.email, subject: 'Your constellation has not been accepted')
  end
end
