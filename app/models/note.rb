class Note
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :body, type: String
  field :tags, type: Array
  field :user_id, type: String
  field :created_at, type: Time
  field :updated_at, type: Time

  belongs_to :user

end
