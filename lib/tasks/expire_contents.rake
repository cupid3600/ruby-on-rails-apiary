task expire_contents: :environment do
  Content.to_expire.update_all(expired: true)
end
