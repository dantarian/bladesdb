require 'rails_helper'

RSpec.describe "Acceptables", type: :request do
  describe "GET /acceptables" do
    it "works! (now write some real specs)" do
      get acceptables_path
      expect(response).to have_http_status(200)
    end
  end
end
