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
        expect(response).to redirect_to(root_path)
      end
    end

    context "user signed in" do
      let(:user) { build(:user) }
      let(:membership) { create(:membership, user: user) }
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

  describe "#show" do
    let(:user) { build(:user) }

    before do
      allow(controller).to receive(:current_user).and_return(user)
    end

    context "user belongs to the group" do
      let(:membership) { create(:membership, user: user) }
      let(:group) { membership.group }

      before do
        get :show, id: group.id
      end

      it "should assign the group" do
        expect(assigns(:group)).to eq(group)
      end
    end

    context "user does not belong to the group" do
      let(:membership) { create(:membership, user: build(:user)) }
      let(:group) { membership.group }

      before do
        get :show, id: group.id
      end

      it "should redirect to group index page" do
        expect(response).to redirect_to(groups_path)
      end
    end
  end
end
