json.extract! user_participant, :id, :first_name, :last_name, :birth_date, :user_admin_id, :created_at, :updated_at
json.url user_participant_url(user_participant, format: :json)
