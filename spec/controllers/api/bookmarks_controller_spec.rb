require "rails_helper"

RSpec.describe Api::BookmarksController, type: :controller do

  describe "POST #create" do
    before do
      @job = FactoryGirl.create(:job)
    end

    context "user authenticated" do
      before do
        @current_user = FactoryGirl.create(:user)
        @bookmarks_count = @current_user.bookmarks.count
        request.headers["Authorization"] = Token.encode(@current_user.id)
        post :create, bookmark: { job_guid: @job.guid }
      end

      it "should respond with 200 ok" do
        expect(response).to have_http_status(:ok)
      end

      it "should add new bookmark belonging to current_user" do
        expect(@current_user.bookmarks.count).to eq(@bookmarks_count + 1)
      end

      it "should render new bookmark as json" do
        expect(response.body).to include("user_id".to_json)
        expect(response.body).to include("job_id".to_json)
      end
    end

    context "user not authenticated" do
      before do
        post :create, bookmark: { job_guid: @job.guid }
      end

      it "should respond with 401 unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end

      it "should render error message" do
        expect(response.body).to include("You must be logged in to do that")
      end
    end
  end

end