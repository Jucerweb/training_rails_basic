class Post < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  has_many :attachments
  has_many :payments
  validates :title, presence: true, uniqueness: true
  before_save :default_price
  include Picturable
  include PublicActivity::Model
  tracked owner: Proc.new{|controller,model|controller.current_user}

  def default_price
    self.price ||= 0
  end

end
