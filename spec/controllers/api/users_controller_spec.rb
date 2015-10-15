require "rails_helper"

RSpec.describe Api::UsersController, type: :controller do

  describe "GET #current" do
    before do
      @current_user = FactoryGirl.create(:user)
      request.headers["Authorization"] = Token.encode(@current_user.id)
      get :current
    end

    it "should respond with 200 ok" do
      expect(response).to have_http_status(:ok)
    end

    it "should render current_user as json" do
      expect(response.body).to include(@current_user.email.to_json)
    end

    it "should not include user id in response" do
      expect(response.body).not_to include("id".to_json + ":" + @current_user.id.to_json)
    end

    it "should not include password_digest in response" do
      expect(response.body).not_to include("password_digest".to_json + ":" + @current_user.password_digest.to_json)
    end

    it "should include user's bookmarked jobs" do
      expect(response.body).to include("jobs".to_json + ":" + @current_user.jobs.to_json)
    end
  end

end