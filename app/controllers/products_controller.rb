class ProductsController < ApplicationController
  before_action :login_required
	before_action :products_params, only: [:create]

  def index
  	@products = Product.all
  end

  def show
  	@product = Product.find(params[:id])
  end

  def new
  	@product = Product.new
  end

  def create
  	@product = Product.new(products_params)
    if @product.save
      redirect_to products_path, notice: 'Todo bien!'
    else
      render 'new'
    end  
  end

  private

  def products_params
  	params.require(:product).permit(:ref, :price, :quantity, :brand, :name, :description, :size, :color)
  end
  
end
