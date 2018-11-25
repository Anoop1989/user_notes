class Note
  include Mongoid::Document
  field :title, type: String
  field :body, type: String
  field :tags, type: Array
  field :user_id, type: String
end
