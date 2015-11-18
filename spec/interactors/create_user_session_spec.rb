require "rails_helper"

RSpec.describe CreateUserSession do
  subject { described_class }

  let(:user) { create(:unconfirmed_user) }

  let(:interactor_context) do
    Interactor::Context.new(errors: :val, user: user)
  end

  let(:authenticate_user) { double("authenticate_user") }
  let(:login_user) { double("login_user") }

  before(:example) do
    allow(AuthenticateUser).to receive(:new).and_return(authenticate_user)
    allow(authenticate_user).to receive(:run!)
    allow(authenticate_user).to receive(:run)
    allow(authenticate_user).to receive(:context)

    allow(LoginUser).to receive(:new).and_return(login_user)
    allow(login_user).to receive(:run!)
    allow(login_user).to receive(:run)
    allow(login_user).to receive(:context)
  end

  describe ".call" do
    it "calls the AuthenticateUser interactor" do
      expect(authenticate_user).to receive(:run!)
      subject.call(interactor_context)
    end

    it "calls the LoginUser interactor" do
      expect(login_user).to receive(:run!)
      subject.call(interactor_context)
    end
  end
end
