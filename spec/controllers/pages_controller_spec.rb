require "rails_helper"

RSpec.describe PagesController, type: :controller do
  let(:work) { Work.create!(title: "Test Work") }
  let(:sheet) { Sheet.create!(work: work, title: "Test Sheet", number: 1) }
  let(:existing_page) { Page.create(valid_attributes) }

  let(:valid_attributes) do
    { sheet_id: sheet.id, title: "Test Page", row: 1, col: 2 }
  end

  let(:invalid_attributes) do
    { sheet_id: sheet.id, title: existing_page.title, row: existing_page.row, col: existing_page.col }
  end

  describe "GET #index" do
    it "returns a success response" do
      Page.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: existing_page.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: { sheet_id: sheet.id }
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: existing_page.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Page" do
        expect do
          post :create, params: { page: valid_attributes }
        end.to change(Page, :count).by(1)
      end

      it "redirects to the created work" do
        post :create, params: { page: valid_attributes }
        expect(response).to redirect_to(Page.last)
      end
    end

    context "with invalid params" do
      it "does not create a page with duplicate title" do
        Page.create!(valid_attributes)
        expect do
          post :create, params: { page: invalid_attributes }
        end.to_not change { Page.count }
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        { title: "Another Title" }
      end

      it "updates the requested page" do
        page = Page.create! valid_attributes
        put :update, params: { id: page.to_param, page: new_attributes }
        page.reload
        expect(page.title).to eq "Another Title"
      end

      it "redirects to the page" do
        page = Page.create! valid_attributes
        put :update, params: { id: page.to_param, page: valid_attributes }
        expect(response).to redirect_to(page)
      end
    end

    context "with invalid params" do
      it "does not update resource" do
        page1_attributes = { sheet_id: sheet.id, title: "Page 1", row: 1, col: 1 }
        page2_attributes = { sheet_id: sheet.id, title: "Page 2", row: 1, col: 2 }
        page1 = Page.create! page1_attributes
        page2 = Page.create! page2_attributes
        put :update, params: { id: page2.to_param, page: page1_attributes }
        expect(page1.reload.title).to eq "Page 1"
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested work" do
      work = Page.create! valid_attributes
      expect do
        delete :destroy, params: { id: work.to_param }
      end.to change(Page, :count).by(-1)
    end

    it "redirects to the page list" do
      work = Page.create! valid_attributes
      delete :destroy, params: { id: work.to_param }
      expect(response).to redirect_to(pages_url)
    end
  end
end
