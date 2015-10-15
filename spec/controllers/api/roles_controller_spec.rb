require "rails_helper"

RSpec.describe Api::RolesController, type: :controller do

  describe "GET #index" do
    before do
      @role = FactoryGirl.create(:role)
      @all_roles = Role.all
      get :index
    end

    it "should respond with 200 ok" do
      expect(response).to have_http_status(:ok)
    end

    it "should assign @roles" do
      expect(assigns(:roles)).to eq(@all_roles)
    end

    it "should render all roles as json" do
      expect(response.body).to include(@role.name.to_json)
      expect(response.body).to include(@role.slug.to_json)
    end

    it "should not include role id in response" do
      expect(response.body).not_to include("id".to_json + ":" + @role.id.to_json)
    end
  end

end