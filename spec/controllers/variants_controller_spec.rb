require 'rails_helper'

RSpec.describe VariantsController, :type => :controller do

  before do
    # This is pure scaffold code, except for a few lines I added for product stuff.  So, these all need to be reworked
    # and turned into proper specs based on actual controller code
    pending "not worrying about controller tests right now"
    @account = FactoryGirl.create(:account)
    @product = Product.create!(name: "extension cord", id: 1)
  end

  # This should return the minimal set of attributes required to create a valid
  # Variant. As you add validations to Variant, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { product_id: 1 }
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # VariantsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all variants as @variants" do
      variant = Variant.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:variants)).to eq([variant])
    end
  end

  describe "GET show" do
    it "assigns the requested variant as @variant" do
      variant = Variant.create! valid_attributes
      get :show, {:id => variant.to_param}, valid_session
      expect(assigns(:variant)).to eq(variant)
    end
  end

  describe "GET new" do
    it "assigns a new variant as @variant" do
      get :new, {}, valid_session
      expect(assigns(:variant)).to be_a_new(Variant)
    end
  end

  describe "GET edit" do
    it "assigns the requested variant as @variant" do
      variant = Variant.create! valid_attributes
      get :edit, {:id => variant.to_param}, valid_session
      expect(assigns(:variant)).to eq(variant)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Variant" do
        expect {
          post :create, {:variant => valid_attributes}, valid_session
        }.to change(Variant, :count).by(1)
      end

      it "assigns a newly created variant as @variant" do
        post :create, {:variant => valid_attributes}, valid_session
        expect(assigns(:variant)).to be_a(Variant)
        expect(assigns(:variant)).to be_persisted
      end

      it "redirects to the created variant" do
        post :create, {:variant => valid_attributes}, valid_session
        expect(response).to redirect_to(Variant.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved variant as @variant" do
        post :create, {:variant => invalid_attributes}, valid_session
        expect(assigns(:variant)).to be_a_new(Variant)
      end

      it "re-renders the 'new' template" do
        post :create, {:variant => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested variant" do
        variant = Variant.create! valid_attributes
        put :update, {:id => variant.to_param, :variant => new_attributes}, valid_session
        variant.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested variant as @variant" do
        variant = Variant.create! valid_attributes
        put :update, {:id => variant.to_param, :variant => valid_attributes}, valid_session
        expect(assigns(:variant)).to eq(variant)
      end

      it "redirects to the variant" do
        variant = Variant.create! valid_attributes
        put :update, {:id => variant.to_param, :variant => valid_attributes}, valid_session
        expect(response).to redirect_to(variant)
      end
    end

    describe "with invalid params" do
      it "assigns the variant as @variant" do
        variant = Variant.create! valid_attributes
        put :update, {:id => variant.to_param, :variant => invalid_attributes}, valid_session
        expect(assigns(:variant)).to eq(variant)
      end

      it "re-renders the 'edit' template" do
        variant = Variant.create! valid_attributes
        put :update, {:id => variant.to_param, :variant => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested variant" do
      variant = Variant.create! valid_attributes
      expect {
        delete :destroy, {:id => variant.to_param}, valid_session
      }.to change(Variant, :count).by(-1)
    end

    it "redirects to the variants list" do
      variant = Variant.create! valid_attributes
      delete :destroy, {:id => variant.to_param}, valid_session
      expect(response).to redirect_to(variants_url)
    end
  end

end
