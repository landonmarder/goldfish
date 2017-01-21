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

  describe "#post" do
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

  describe "#put" do
    let(:user) { build(:user) }
    let!(:group_activity) { create(:group_activity) }
    let(:group) { group_activity.group }

    before do
      allow(controller).to receive(:current_user).and_return(user)
    end

    context "the user belongs to the group" do
      before do
        put :update, group_id: group.id, id: group_activity.id, group_activity: { completed_at: Time.now.to_s }
      end

      it "should update the completed at" do
        expect(group_activity.reload.completed_at).to be_present
      end
    end
  end

  describe "#destroy" do
    let(:user) { build(:user) }
    let!(:group_activity) { create(:group_activity) }
    let(:group) { group_activity.group }

    before do
      allow(controller).to receive(:current_user).and_return(user)
    end

    context "the user belongs to the group" do
      it "should delete the group activity" do
        expect {
          delete :destroy, group_id: group.id, id: group_activity.id
        }.to change { group.group_activities.count }.by(-1)
      end
    end
  end
end
