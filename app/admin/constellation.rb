ActiveAdmin.register Constellation do
  permit_params :name, :icon

  form do |f|
    f.inputs 'Details' do
      f.input :name
      f.input :icon
    end

    actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :icon
    column :created_at
    column :updated_at

    actions
  end

  filter :id
  filter :name
  filter :created_at
  filter :updated_at

  show do
    attributes_table do
      row :id
      row :name
      row :icon
      row :created_at
      row :updated_at
    end
  end
end
