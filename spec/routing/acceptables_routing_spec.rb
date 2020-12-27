require "rails_helper"

RSpec.describe AcceptablesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/acceptables").to route_to("acceptables#index")
    end

    it "routes to #new" do
      expect(:get => "/acceptables/new").to route_to("acceptables#new")
    end

    it "routes to #show" do
      expect(:get => "/acceptables/1").to route_to("acceptables#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/acceptables/1/edit").to route_to("acceptables#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/acceptables").to route_to("acceptables#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/acceptables/1").to route_to("acceptables#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/acceptables/1").to route_to("acceptables#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/acceptables/1").to route_to("acceptables#destroy", :id => "1")
    end

  end
end
