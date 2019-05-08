json.about_to_expire do
  json.array! @about_to_expire, partial: 'api/v1/contents/info', as: :content
end

json.popular do
  json.array! @popular, partial: 'api/v1/contents/info', as: :content
end

json.common do
  json.array! @common, partial: 'api/v1/contents/info', as: :content
end
