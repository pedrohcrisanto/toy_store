require 'rails_helper'

RSpec.describe "Api::V1::Statistics", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/statistics/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /sales_by_day" do
    it "returns http success" do
      get "/api/v1/statistics/sales_by_day"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /top_clients" do
    it "returns http success" do
      get "/api/v1/statistics/top_clients"
      expect(response).to have_http_status(:success)
    end
  end

end
