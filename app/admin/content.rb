ActiveAdmin.register Content do
  permit_params :disable, constellation_ids: []

  actions :all, except: [:new]

  scope :all
  scope :videos
  scope :audios
  scope :shooting_stars

  scope :expired

  form do |f|
    f.inputs 'Details' do
      f.input :constellations,
              as: :check_boxes,
              collection: Constellation.to_dropdown_ordered
      f.input :disable, label: 'Block content'
    end
    actions
  end

  index do
    selectable_column
    id_column
    column :user
    column :type
    column :created_at
    column :updated_at
    column :blocked, :disable

    actions
  end

  filter :id
  filter :user
  filter :type
  filter :disable
  filter :created_at
  filter :updated_at

  show do |f|
    attributes_table do
      row :id
      row :user
      row :type
      row :disable
      if f.type == 'Video'
        row :file do |video|
          video_tag video.file.url, controls: true, autobuffer: true, height: 200, width: 200
        end
        row :thumbnail do |video|
          image_tag video.file.url(:thumb)
        end
      else
        row ('audio url') { |p| link_to(p.file_url, p.file_url) }
      end
      row :created_at
      row :updated_at
    end

    panel 'Constellations' do
      table_for(f.constellations) do
        column :id
        column :name
      end
    end
  end

  controller do
    def scoped_collection
      super.includes(:user)
    end
  end
end
