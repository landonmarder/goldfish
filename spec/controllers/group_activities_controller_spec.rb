require "rails_helper"

RSpec.describe GroupActivitiesController do
  describe "#index" do
    let(:user) { build(:user) }

    before do
      allow(controller).to receive(:current_user).and_return(user)
    end

    context "user belongs to the group" do
      let(:membership) { create(:membership, user: user) }
      let(:group) { membership.group }

      before do
        get :index, group_id: group.id
      end

      it "should assign the group" do
        expect(assigns(:group)).to eq(group)
      end
    end

    context "user does not belong to the group" do
      let(:membership) { create(:membership, user: build(:user)) }
      let(:group) { membership.group }

      before do
        get :index, group_id: group.id
      end

      it "should redirect to group index page" do
        expect(response).to redirect_to(groups_path)
      end
    end
  end
end
