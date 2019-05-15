json.interests_planets do
  json.array! @interests_planets, partial: 'api/v1/interests_planets/info', as: :interests_planet
end
