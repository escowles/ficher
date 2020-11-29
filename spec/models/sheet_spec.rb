require "rails_helper"

RSpec.describe Sheet, type: :model do
  subject(:sheet) { Sheet.create(title: "Test Sheet", number: 1, work: work1) }
  let(:work1) { Work.create(title: "Test Work") }
  let(:work2) { Work.create(title: "Another Work") }

  describe "title" do
    it "has a title" do
      expect(sheet.title).to eq "Test Sheet"
    end
    it "must be unique" do
      expect { Sheet.create!(title: sheet.title) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "number" do
    it "has a number" do
      expect(sheet.number).to eq 1
    end
    it "must be unique within the same work" do
      expect { Sheet.create!(work: work1, number: sheet.number) }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "can be duplicated in different works" do
      expect { Sheet.create!(work: work2, number: sheet.number) }.not_to raise_error
    end
  end
end
