require "rails_helper"

RSpec.describe Page, type: :model do
  subject(:page) { Page.create(title: "Page 2", row: 1, col: 2, sheet: sheet1) }
  let(:sheet1) { Sheet.create(title: "First Sheet", number: 1, work: work1) }
  let(:sheet2) { Sheet.create(title: "Second Sheet", number: 2, work: work1) }
  let(:work1) { Work.create(title: "Test Work") }

  describe "row/col" do
    it "has a row and col" do
      expect(page.row).to eq 1
      expect(page.col).to eq 2
    end
    it "must be unique within the same sheet" do
      expect { Page.create!(sheet: sheet1, row: page.row, col: page.row) }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "can be duplicated in different works" do
      expect { Page.create!(sheet: sheet2, row: page.row, col: page.row ) }.not_to raise_error
    end
  end
end
