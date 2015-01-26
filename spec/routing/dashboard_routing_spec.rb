require "spec_helper"

describe DashboardController do
  describe "routing" do

    it "routes to #index" do
      get("/").should route_to("dashboard#index")
    end

    it "routes to #create_contest" do
      post("/create_contest").should route_to("dashboard#create_contest")
    end

    it "routes to #test_connection" do
      get("/test_connection").should route_to("dashboard#test_connection")
    end

  end
end
