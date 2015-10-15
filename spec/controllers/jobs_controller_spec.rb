require "rails_helper"

RSpec.describe Api::JobsController, type: :controller do

  describe "GET #index" do
    before do
      @all_jobs = Job.all
      get :index
    end

    it "should respond with 200 ok" do
      expect(response).to have_http_status(:ok)
    end

    it "should assign @jobs" do
      expect(assigns(:jobs)).to eq(@all_jobs)
    end

    it "should render all jobs as json" do
      expect(response.body).to eq(@all_jobs.to_json)
    end
  end

end