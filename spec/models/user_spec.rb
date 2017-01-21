require "rails_helper"

RSpec.describe User do
  describe "#membership_for" do
    context "user is member of group" do
      let!(:membership) { create(:membership) }
      let(:group) { membership.group }
      let(:subject) { membership.user }

      it "should return the user's membership for that group" do
        expect(subject.membership_for(group)).to eq(group)
      end
    end

    context "user is not member of group" do
      let(:group) { create(:group) }
      let(:subject) { create(:user) }

      it "should return nil" do
        expect(subject.membership_for(group)).to be_nil
      end
    end
  end
end
