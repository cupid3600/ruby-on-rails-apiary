ActiveAdmin.register User do
  permit_params :email, :username, :password, :password_confirmation

  form do |f|
    f.inputs 'Details' do
      f.input :email
      f.input :username

      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
    end

    actions
  end

  index do
    selectable_column
    id_column
    column :email
    column :username
    column :sign_in_count
    column :created_at
    column :updated_at

    actions
  end

  filter :id
  filter :email
  filter :username
  filter :created_at
  filter :updated_at

  show do
    attributes_table do
      row :id
      row :email
      row :username
      row :sign_in_count
      row :created_at
      row :updated_at
    end
  end
end
