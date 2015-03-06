class SellsController < ApplicationController
  def index
  	@sells = Sell.all
  end

  def show
  	@sell = Sell.find(params[:id])
  end
end
