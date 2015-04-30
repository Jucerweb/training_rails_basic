class Transaction < ActiveRecord::Base
  belongs_to :user
  validates :token, presence: true
  validates :payerid, presence: true
  validates :ip_address, presence: true

  def pay?
    response = proccess_purchase
    self.feed = response.message
    self.save
    if response.success?
      self.user.payments.each do |payment|
        payment.update(status:2)
      end
      true
    else
      false
    end
  end
  private
  def proccess_purchase
    EXPRESS_GATEWAY.purchase(self.user.total_shopping * 100, options_purchase)
  end

  def options_purchase
    {
      ip: self.ip_address,
      token: self.token,
      payer_id: self.payerid
    }
  end
end
