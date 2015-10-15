require "rails_helper"

RSpec.describe Api::LocationsController, type: :controller do

  describe "GET #index" do
    before do
      @location = FactoryGirl.create(:location)
      @all_locations = Location.all
      get :index
    end

    it "should respond with 200 ok" do
      expect(response).to have_http_status(:ok)
    end

    it "should assign @locations" do
      expect(assigns(:locations)).to eq(@all_locations)
    end

    it "should render all locations as json" do
      expect(response.body).to include(@location.city.to_json)
      expect(response.body).to include(@location.state.to_json)
      expect(response.body).to include(@location.country.to_json)
      expect(response.body).to include(@location.latitude.to_json)
      expect(response.body).to include(@location.longitude.to_json)
      expect(response.body).to include(@location.slug.to_json)
    end

    it "should not include location id in response" do
      expect(response.body).not_to include({ id: @location.id }.to_json)
    end
  end

end