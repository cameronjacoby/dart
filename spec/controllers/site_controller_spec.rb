require "rails_helper"

RSpec.describe SiteController, type: :controller do

  describe "GET #index" do
    before do
      get :index
    end

    it "should respond with 200 ok" do
      expect(response).to have_http_status(:ok)
    end

    it "should render the :index view" do
      expect(response).to render_template(:index)
    end
  end

end