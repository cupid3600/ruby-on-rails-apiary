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

  def reset_password_code_email(code)
    @user = code.user
    @code = code.code

    mail(to: @user.email, subject: 'Reset Password Request')
  end
end
