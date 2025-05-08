class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list

  validates :comment, length: { minimum: 6 }
  validates_associated :list
  validates_associated :movie
  validates :movie_id, uniqueness: {scope: :list_id, message: "is already in the list"}
end
