require "rails_helper"

RSpec.describe GroupsController do
  describe "#index" do
    context "user signed out" do
      let!(:group) { create(:group) }

      before do
        allow(controller).to receive(:current_user).and_return(nil)
        get :index
      end

      it "should redirect to the home page" do
        expect(response).should redirect_to(root_path)
      end
    end

    context "user signed in" do
      let!(:user) { create(:user) }
      let!(:membership) { create(:membership, user: user) }
      let!(:group_user_belongs_to) { membership.group }
      let!(:other_group) { create(:group) }

      before do
        allow(controller).to receive(:current_user).and_return(user)
        get :index
      end

      it "should only show groups the user is a part of" do
        expect(assigns(:groups)).to match_array([group_user_belongs_to])
      end
    end
  end
end
