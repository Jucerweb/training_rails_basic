class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook, :twitter]
  has_many :payments
  has_many :post
  has_many :friendships, foreign_key: "user_id", dependent: :destroy
  has_many :follows, through: :friendships, source: :friend
  has_many :followers_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :followers, through: :followers_friendships, source: :user

  def follow!(id_friend)
    self.friendships.create!(friend_id: id_friend)
  end

  def can_follow?(id_friend)
    not id_friend == self.id or friendships.where(friend_id: id_friend).size > 0
  end

  def email_required?
    false
  end

  def total_shopping
    self.payments.where(status:1).joins("INNER JOIN posts on posts.id == payments.post_id").sum("price")
  end

  validates :username, presence: true, uniqueness: true, length:{in: 5..20, too_short: "5 characters minimun", too_long: "20 characters maximun"},
    format: {with: /([A-Za-z0-9\-\_]+)/,message: "characters no valid"}
  #validate :my_validate, on: :create

  def self.find_or_create_by_omniauth(auth)
    user = User.where(provider: auth[:provider], uid: auth[:uid]).first
    return user if user
    user = User.create(
      name: auth[:name],
      surname: auth[:surname],
      username: auth[:username],
      email: auth[:email],
      uid: auth[:uid],
      provider: auth[:provider],
      password: Devise.friendly_token[0,20]
    )
  end

  #private
  # def my_validate
  #   if true

  #   else
  #     errors.add(:username,"You username is invalid")
  #   end
  # end
end
