json.shooting_star do
  if @new_star
    json.partial! 'info', shooting_star: @new_star
  else
    json.nil!
  end
end
