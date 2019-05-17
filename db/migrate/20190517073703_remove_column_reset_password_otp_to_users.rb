class RemoveColumnResetPasswordOtpToUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :reset_password_otp, :string
  end
end
