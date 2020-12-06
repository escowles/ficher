require "rails_helper"

RSpec.describe SheetsController, type: :controller do
  let(:work) { Work.create(title: "Test Work") }
  let(:existing_sheet) { Sheet.create(valid_attributes) }

  let(:valid_attributes) do
    { work_id: work.id, title: "Test Sheet", number: 1 }
  end

  let(:invalid_attributes) do
    { work_id: work.id, title: existing_sheet.title, number: existing_sheet.number }
  end

  describe "GET #index" do
    it "returns a success response" do
      Sheet.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: existing_sheet.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: { work_id: work.id }
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: existing_sheet.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Sheet" do
        expect do
          post :create, params: { sheet: valid_attributes }
        end.to change(Sheet, :count).by(1)
      end

      it "redirects to the created work" do
        post :create, params: { sheet: valid_attributes }
        expect(response).to redirect_to(Sheet.last)
      end
    end

    context "with invalid params" do
      it "does not create a sheet with duplicate title" do
        Sheet.create!(valid_attributes)
        expect do
          post :create, params: { sheet: invalid_attributes }
        end.to_not change { Sheet.count }
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        { title: "Another Title" }
      end

      it "updates the requested sheet" do
        work = Sheet.create! valid_attributes
        put :update, params: { id: work.to_param, sheet: new_attributes }
        work.reload
        expect(work.title).to eq "Another Title"
      end

      it "redirects to the sheet" do
        work = Sheet.create! valid_attributes
        put :update, params: { id: work.to_param, sheet: valid_attributes }
        expect(response).to redirect_to(work)
      end
    end

    context "with invalid params" do
      it "does not update resource" do
        sheet1 = Sheet.create! work_id: work.id, title: "Sheet 1", number: 1
        sheet2 = Sheet.create! work_id: work.id, title: "Sheet 2", number: 2
        put :update, params: { id: sheet2.to_param, sheet: { title: "Sheet 1" } }
        expect(sheet2.reload.title).to eq "Sheet 2"
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested work" do
      work = Sheet.create! valid_attributes
      expect do
        delete :destroy, params: { id: work.to_param }
      end.to change(Sheet, :count).by(-1)
    end

    it "redirects to the sheets list" do
      work = Sheet.create! valid_attributes
      delete :destroy, params: { id: work.to_param }
      expect(response).to redirect_to(sheets_url)
    end
  end
end
