class TransactionsController < ApplicationController
  before_action :authenticate_user!
  def checkout
    @transaction = current_user.transactions.new(payerid: strong_params[:PayerID], token: strong_params[:token])
    @transaction.ip_address = request.remote_ip
    @transaction.save
    respond_to do |format|
      if @transaction.pay?
        format.html {redirect_to "/", notice: "Thanks for your purchase"}
      else
        format.html {redirect_to car_path}
      end
    end
  end

  private
  def strong_params
    params.permit(:token, :PayerID)
  end
end
