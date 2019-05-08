ActiveAdmin.register ConstellationRequest do
  actions :index, :show

  includes :user

  index do
    selectable_column
    id_column
    column :name
    column :reason
    column :status
    column :user
    column :created_at
    column :updated_at
    actions do |request|
      item 'Accept',
           accept_admin_constellation_request_path(request),
           class: 'member_link' unless request.accepted?
      item 'Reject',
           reject_admin_constellation_request_path(request),
           class: 'member_link' if request.pending?
    end
  end

  filter :name
  filter :created_atpcon
  filter :updated_at

  show do
    attributes_table do
      row :id
      row :name
      row :reason
      row :status
      row :created_at
      row :updated_at
    end
  end

  member_action :accept do
    constellation = resource.accept!
    flash[:notice] = 'The constellation was succesfully created. You should add an icon.'
    redirect_to edit_admin_constellation_path(constellation)
  end

  member_action :reject do
    resource.reject!
    redirect_to :admin_constellation_requests
  end
end
