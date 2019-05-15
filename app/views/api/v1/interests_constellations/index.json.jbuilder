json.interests_constellations do
  json.array! @interests_constellations, partial: 'api/v1/interests_constellations/info', as: :interests_constellation
end
