json.extract! note, :id, :title, :body, :tags, :user_id, :created_at, :updated_at
json.url note_url(note, format: :json)
