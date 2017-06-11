class Post < ApplicationRecord
  # validations
  validates_presence_of :content, :user

  self.per_page = 10
end
