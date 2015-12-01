require "rails_helper"

RSpec.describe Todo do
  context "attributes" do
    %w(description user_id).each do |attribute|
      it { is_expected.to have_attribute attribute }
    end
  end

  context "validations" do
    it { is_expected.to validate_presence_of :description }
  end

  context "methods" do
    let(:todo) { create(:todo) }

    describe "#days_left" do
      it "returns the days left until deletion" do
        todo.update_attribute(:created_at, (DateTime.now.utc - 1))
        expect(todo.days_left).to eq 6
      end
    end
  end

  context "relationships" do
    it { is_expected.to belong_to :user }
  end
end
