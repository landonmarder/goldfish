require "rails_helper"

RSpec.describe Membership do
  describe "relationship" do
    let!(:subject) { create(:membership) }

    its(:user) { is_expected.to be_present }
    its(:group) { is_expected.to be_present }
  end
end
