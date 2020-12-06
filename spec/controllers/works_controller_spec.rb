require "rails_helper"

RSpec.describe WorksController, type: :controller do
  let(:existing_work) { Work.create(valid_attributes) }

  let(:valid_attributes) do
    { title: "Test Work" }
  end

  let(:invalid_attributes) do
    { title: existing_work.title }
  end

  describe "GET #index" do
    it "returns a success response" do
      Work.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: existing_work.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: existing_work.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Work" do
        expect do
          post :create, params: { work: valid_attributes }
        end.to change(Work, :count).by(1)
      end

      it "redirects to the created work" do
        post :create, params: { work: valid_attributes }
        expect(response).to redirect_to(Work.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { work: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        { title: "Another Title" }
      end

      it "updates the requested work" do
        work = Work.create! valid_attributes
        put :update, params: { id: work.to_param, work: new_attributes }
        work.reload
        expect(work.title).to eq "Another Title"
      end

      it "redirects to the work" do
        work = Work.create! valid_attributes
        put :update, params: { id: work.to_param, work: valid_attributes }
        expect(response).to redirect_to(work)
      end
    end

    context "with invalid params" do
      it "does not update resource" do
        work1 = Work.create! title: "Work 1"
        work2 = Work.create! title: "Work 2"
        put :update, params: { id: work2.to_param, work: { title: "Work 1" } }
        expect(work2.reload.title).to eq "Work 2"
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested work" do
      work = Work.create! valid_attributes
      expect do
        delete :destroy, params: { id: work.to_param }
      end.to change(Work, :count).by(-1)
    end

    it "redirects to the work list" do
      work = Work.create! valid_attributes
      delete :destroy, params: { id: work.to_param }
      expect(response).to redirect_to(works_url)
    end
  end
end
