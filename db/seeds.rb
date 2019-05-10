AdminUser.create!(email: 'admin@example.com', password: 'password') unless AdminUser.find_by(email: 'admin@example.com')

#Seed Constellations
icon_default = "#{ENV['BUCKET_URL']}/default/constellations"

['addiction', 'bullying', 'good juju', 'health', 'heart-break', 'family',
 'job', 'lgbtq', 'death', 'love', 'ptsd', 'stress', 'meditation'].each do |constellation|
  Constellation.create(name: constellation, icon: "#{icon_default}/#{constellation}.png") unless Constellation.find_by(name: constellation)
end

#Seed Goals
[
    {id: 1, slug: "advice", title: "Advice"},
    {id: 2, slug: "encouragement", title: "Encouragement"},
    {id: 3, slug: "share_my_story", title: "Share my story"},
    {id: 4, slug: "help_someone", title: "'Help someone"}
].each do |goal|
  Goal.create(id: goal[:id],slug: goal[:slug], title: goal[:title]) unless Goal.find_by(id: goal[:id])
end
