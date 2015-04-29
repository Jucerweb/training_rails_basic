class Payment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates :post_id, presence: true
  validates :user_id, presence: true
  before_save :default_value

  private
  def default_value
    self.status ||= 1
  end
end
