require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    let(:product) { create(:product) }

    it 'returns the requested product' do
      get :show, params: { id: product.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:product_type) { create(:product_type) }

      it 'creates a new product' do
        post :create, params: { name: Faker::Name.unique.name, length: 10, width: 10, height: 10, weight: 10, product_type_id: product_type.id }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attributes' do
      it 'returns an error' do
        post :create, params: { name: '', length: 10, width: 10, height: 10, weight: 10 }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    let!(:product_type) { create(:product_type) }
    let!(:product) { create(:product, product_type: product_type) }
    let!(:unique_name) { Faker::Name.unique.name }

    context 'with valid attributes' do
      it 'updates the product' do
        patch :update, params: { id: product.id, name: unique_name, length: 12, width: 12, height: 12, weight: 12, product_type_id: product_type.id }
        expect(response).to be_successful
        product.reload
        expect(product.name).to eq(unique_name)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the product' do
        patch :update, params: { id: product.id, name: '', length: 12 }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:product) { create(:product) }

    it 'deletes the product' do
      expect {
        delete :destroy, params: { id: product.id }
      }.to change(Product, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end

  describe 'GET #match' do
    let!(:product) { create(:product, length: 10, width: 10, height: 10, weight: 10) }

    context 'with matching dimensions' do
      it 'returns a product' do
        get :match, params: { length: 10, width: 10, height: 10, weight: 10 }
        expect(response).to be_successful
      end
    end

    context 'with missing dimensions' do
      it 'returns an error' do
        get :match, params: { length: 10, width: 10 }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
