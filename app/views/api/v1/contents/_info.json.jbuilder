json.id         content.id
json.file       content.file_url
json.thumbnail  content.file.url(:thumb) if content.is_a?(Video)
json.type       content.type
json.created_at content.created_at
json.constellations do
  json.array! content.constellations, partial: 'api/v1/constellations/info', as: :constellation
end
json.owner do
  json.partial! 'api/v1/users/info', user: content.user
end
json.flagged   content.flagged_by?(current_user)
json.favorited content.hearted_by?(current_user)
