json.goals do
  json.array! @goals, partial: 'api/v1/goals/info', as: :goal
end
