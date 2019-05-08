json.contents do
  json.array! @contents, partial: 'info', as: :content
end
json.total current_user.hearted_contents.count
