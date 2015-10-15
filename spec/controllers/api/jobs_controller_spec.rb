require "rails_helper"

RSpec.describe Api::JobsController, type: :controller do

  describe "GET #index" do
    before do
      @job = FactoryGirl.create(:job)
      @active_jobs = Job.active.order("created_at DESC")
      get :index
    end

    it "should respond with 200 ok" do
      expect(response).to have_http_status(:ok)
    end

    it "should assign @jobs to all active jobs" do
      expect(assigns(:jobs)).to eq(@active_jobs)
    end

    it "should render all active jobs as json" do
      expect(response.body).to include(@job.title.to_json)
      expect(response.body).to include(@job.description.to_json)
      expect(response.body).to include(@job.guid.to_json)
    end

    it "should not include job id in response" do
      expect(response.body).not_to include("id".to_json + ":" + @job.id.to_json)
    end
  end

  describe "GET #show" do
    before do
      @job = FactoryGirl.create(:job)
      get :show, id: @job.guid
    end

    it "should respond with 200 ok" do
      expect(response).to have_http_status(:ok)
    end

    it "should assign @job" do
      expect(assigns(:job)).to eq(@job)
    end

    it "should render job as json" do
      expect(response.body).to include(@job.title.to_json)
      expect(response.body).to include(@job.description.to_json)
      expect(response.body).to include(@job.guid.to_json)
    end

    it "should not include job id in response" do
      expect(response.body).not_to include("id".to_json + ":" + @job.id.to_json)
    end
  end

end