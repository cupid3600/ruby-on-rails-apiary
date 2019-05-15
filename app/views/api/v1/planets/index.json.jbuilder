json.planets do
  json.array! @planets, partial: 'api/v1/planets/info', as: :planet
end
