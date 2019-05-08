namespace :shooting_stars do
  desc 'Notify new shooting stars'
  task notify_new: :environment do
    Content.notify_shooting_stars
  end
end
