require 'rails_helper'

describe 'rails expire_contents', type: :task do
  it 'preloads the Rails environment' do
    expect(task.prerequisites).to include 'environment'
  end

  let!(:new_content) { create(:content) }
  let!(:old_content) { create(:content, created_at: ENV['DAYS_TO_EXPIRE'].to_i.days.ago) }

  it 'changes the task to expired' do
    expect { task.execute }.to change { old_content.reload.expired }.from(false).to(true)
    expect { task.execute }.to_not change { new_content.reload.expired }
  end
end
