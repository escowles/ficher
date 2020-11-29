require "rails_helper"

RSpec.describe Work, type: :model do
  subject(:work) { Work.create(title: "Test Title") }

  describe "titl" do
    it "has a title" do
      expect(work.title).to eq "Test Title"
    end
    it "must be unique" do
      expect { Work.create!(title: work.title) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
