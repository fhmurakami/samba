json.extract! report, :id, :user_admin_id, :user_participant_id, :collection_id, :grouping_id, :created_at, :updated_at
json.url report_url(report, format: :json)
