require "spec_helper"

describe HistoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/histories").should route_to("histories#index")
    end

    it "routes to #new" do
      get("/histories/new").should route_to("histories#new")
    end

    it "routes to #show" do
      get("/histories/1").should route_to("histories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/histories/1/edit").should route_to("histories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/histories").should route_to("histories#create")
    end

    it "routes to #update" do
      put("/histories/1").should route_to("histories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/histories/1").should route_to("histories#destroy", :id => "1")
    end

  end
end
