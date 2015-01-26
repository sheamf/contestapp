require 'spec_helper'

describe DashboardController do

  before do
    # We need an Account in the system
    @account = FactoryGirl.create(:account)
  end
  # This should return the minimal set of attributes required to create a valid
  # Account. As you add validations to Account, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {} }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AccountsController. Be sure to keep this updated too.
  let(:valid_session) { {current_account_id: @account.id} }

  describe "GET test_connection" do
    it "tests the connection to Shopify" do

      integration = mock()
      ShopifyIntegration.should_receive(:new).and_return(integration)
      integration.should_receive(:connect)
      ShopifyAPI::Shop.should_receive(:current)

      get :test_connection, {:id => @account.to_param}, valid_session
    end
  end
end
