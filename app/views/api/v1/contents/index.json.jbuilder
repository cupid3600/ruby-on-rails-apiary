json.contents do
  json.array! @contents, partial: 'api/v1/contents/info', as: :content
end
