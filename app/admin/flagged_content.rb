ActiveAdmin.register Content, as: 'Flagged Content' do
  permit_params :disable, constellation_ids: []

  actions :all, except: [:new]

  form do |f|
    f.inputs 'Details' do
      f.input :constellations,
              as: :check_boxes,
              collection: Constellation.to_dropdown_ordered
      f.input :disable, label: 'Block content'
    end
    actions
  end

  member_action :block do
    resource.update!(disable: true)
    redirect_to :admin_flagged_contents
  end

  member_action :unblock do
    resource.update!(disable: false)
    redirect_to :admin_flagged_contents
  end

  index do
    selectable_column
    id_column
    column :user
    column :type
    column :created_at
    column :updated_at
    column :blocked, :disable
    column 'Number of flags', :flags_count
    actions defaults: false, name: 'Block/Unblock actions', dropdown: false do |cont|
      if cont.disable
        item 'UNBLOCK', unblock_admin_flagged_content_path(cont), class: 'unblock_link member_link'
      else
        item 'BLOCK', block_admin_flagged_content_path(cont), class: 'block_link member_link'
      end
    end
    actions
  end

  filter :id
  filter :user
  filter :type
  filter :disable
  filter :flags_count
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
      else
        row ('audio url') { |p| link_to(p.file_url, p.file_url) }
      end
      row :created_at
      row :updated_at
    end
  end

  controller do
    def scoped_collection
      super.flagged.includes(:user)
    end
  end
end
