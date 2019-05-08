AdminUser.create!(email: 'admin@example.com', password: 'password') unless AdminUser.find_by(email: 'admin@example.com')

icon_default = "#{ENV['BUCKET_URL']}/default/constellations"

['addiction', 'bullying', 'good juju', 'health', 'heart-break', 'family',
 'job', 'lgbtq', 'death', 'love', 'ptsd', 'stress', 'meditation'].each do |constellation|
  Constellation.create(name: constellation, remote_icon_url: "#{icon_default}/#{constellation}.png") unless Constellation.find_by(name: constellation)
end
