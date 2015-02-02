class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def import
    # if product import isn't done first, and the orders contain products that haven't been imported, the order import
    # will fail.  Should call the product import here to make sure this can't happen

    # instantiate the shopify integration class
    shopify_integration = ShopifyIntegration.new(api_key: current_account.shopify_api_key,
                                                 shared_secret: current_account.shopify_shared_secret,
                                                 url: current_account.shopify_account_url,
                                                 password: current_account.shopify_password)

    respond_to do |format|
      if shopify_integration.connect
        result = shopify_integration.import_orders
        format.html { redirect_to ({action: :index}), notice: "#{result[:created].to_i} created, #{result[:updated]} updated, #{result[:failed]} failed." }
        format.json { render json: "#{result[:created].to_i} created,  #{result[:updated]} updated, #{result[:failed]} failed." }
      else
        format.html { redirect_to ({action: :index}), alert: "Unable to connect to Shopify" }
        format.json { render json: "Unable to connect to Shopify", status: :unprocessable_entity }
      end
    end
  end

  def index
    @orders = current_account.orders.all
  end

  def show
  end

  def new
    @order = current_account.orders.new
  end

  def edit
  end

  def create
    @order = current_account.orders.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = current_account.orders.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:number, :email, :first_name, :last_name, :shopify_order_id, :order_date, :total, :line_item_count, :financial_status)
    end
end
