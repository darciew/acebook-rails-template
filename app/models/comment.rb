class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :message, presence: true

  include ActionView::Helpers::DateHelper

  def time_ago
    full_time = created_at
    "#{time_ago_in_words(full_time)} ago"
  end
end
