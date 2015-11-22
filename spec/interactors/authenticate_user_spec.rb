require "rails_helper"

RSpec.describe AuthenticateUser do
  describe ".call" do
    let(:user)             { create(:confirmed_user) }
    let(:unconfirmed_user) { create(:unconfirmed_user) }

    context "when given valid credentials" do
      subject(:context) do
        described_class.call(email: user.email, password: user.password)
      end

      it "succeeds" do
        expect(context).to be_a_success
      end

      it "provides the user" do
        expect(context.user).to eq(user)
      end
    end

    context "when given invalid user" do
      subject(:context) do
        described_class.call(email: "fake@bs.com", password: user.password)
      end

      it "fails" do
        expect(context).to be_a_failure
      end
    end

    context "when given invalid password" do
      subject(:context) do
        described_class.call(email: user.email, password: "nope")
      end

      it "fails" do
        expect(context).to be_a_failure
      end
    end

    context "when email not confirmed" do
      subject(:context) do
        described_class.call(email:    unconfirmed_user.email,
                             password: unconfirmed_user.password)
      end

      it "fails" do
        expect(context).to be_a_failure
      end
    end
  end
end
