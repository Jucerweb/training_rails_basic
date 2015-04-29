class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @payment = current_user.payments.new(post_params)
    respond_to do |format|
      if @payment.save
        format.html {redirect_to car_path }
        format.json {head :no_content}
      else
        redirect_to Post.find(post_params[:post_id], error: "Unable to process your purchase")
      end
    end
  end

  def car
    @payments = current_user.payments.where(status:1)
  end

  def express
    cost = current_user.total_shopping
    response = EXPRESS_GATEWAY.setup_purchase(cost * 100,
      ip: request.remote_ip,
      return_url: "http://localhost:3000/transactions/checkout",
      cancel_return_url: "http://localhost:3000/car",
      name: "Checkout of Market Koombea",
      amount: cost  * 100
      )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token, review: false)
  end

  private
  def post_params
    params.require(:payment).permit(:post_id)
  end
end
