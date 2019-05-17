class AddColumnResetPasswordOtpToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :reset_password_otp, :string
  end
end
