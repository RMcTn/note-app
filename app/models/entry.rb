class Entry < ApplicationRecord
  validates :title, presence: true
  belongs_to :user
  has_rich_text :content
  after_create_commit -> { broadcast_prepend_to user, target: "entries-container" }
  after_destroy_commit -> { broadcast_remove_to user }
  after_update_commit -> { broadcast_update_to user }
end
