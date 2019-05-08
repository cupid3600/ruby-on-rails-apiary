json.constellations do
  json.array! @constellations, partial: 'info', as: :constellation
end
