class Entry < ApplicationRecord
  validates :title, presence: true
  belongs_to :user
  has_rich_text :content
  after_create_commit -> { broadcast_prepend_to user, target: "entry-container" }
end
