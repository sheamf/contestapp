class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def import
    # instantiate the shopify integration class
    shopify_integration = ShopifyIntegration.new(url: current_account.shopify_account_url,
                                                 password: current_account.shopify_password,
                                                 account_id: current_account.id)

    respond_to do |format|
      if shopify_integration.connect
        result = shopify_integration.import_products
        format.html { redirect_to ({action: :index}), notice: "#{result[:created].to_i} created, #{result[:updated]} updated, #{result[:failed]} failed." }
        format.json { render json: "#{result[:created].to_i} created,  #{result[:updated]} updated, #{result[:failed]} failed." }
      else
        format.html { redirect_to ({action: :index}), alert: "Unable to connect to Shopify" }
        format.json { render json: "Unable to connect to Shopify", status: :unprocessable_entity }
      end
    end
  end

  def index
    @products = current_account.products.all
  end

  def show
  end

  def new
    @product = current_account.products.new
  end

  def edit
  end

  def create
    @product = current_account.products.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = current_account.products.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :shopify_product_id, :last_shopify_sync)
    end
end
