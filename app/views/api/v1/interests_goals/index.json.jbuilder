json.interests_goals do
  json.array! @interests_goals, partial: 'api/v1/interests_goals/info', as: :interests_goal
end
