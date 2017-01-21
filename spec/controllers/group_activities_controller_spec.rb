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

  describe "#POST" do
    let(:user) { create(:user) }

    before do
      allow(controller).to receive(:current_user).and_return(user)
    end

    context "user and group exist" do
      let(:activity) { create(:activity) }
      let(:group) { create(:group) }

      context "the user belongs to the group" do
        let!(:membership) { create(:membership, group: group, user: user) }

        it "should create a group activity" do
          expect {
            post :create, group_id: group.id, group_activity: { activity_id: activity.id }
          }.to change { group.group_activities.count }.by(1)
        end
      end

      context "the user does not belong to the group" do
        it "should not create a group activity" do
          expect {
            post :create, group_id: group.id, group_activity: { activity_id: activity.id }
          }.to change { group.group_activities.count }.by(0)
        end
      end
    end
  end
end
