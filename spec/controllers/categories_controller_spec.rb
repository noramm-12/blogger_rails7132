require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let!(:category) {create(:category)}
  let!(:user) {create(:no_admin_user)}
  let!(:admin_user) {create(:admin_user)}

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns @categories' do
      get :index
      expect(assigns(:categories)).to eq([category])
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: category.id }
      expect(response).to be_successful
    end

    it 'assigns @category' do
      get :show, params: { id: category.id }
      expect(assigns(:category)).to eq(category)
    end

    it 'redirects to root path if category is not found' do
      get :show, params: { id: -1 }
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET #new' do
    context 'when admin' do
      before { login_in_as admin_user }

      it 'returns a successful response' do
        get :new
        expect(response).to be_successful
      end
    end
    #
    # context 'when non-admin' do
    #   before { sign_in_as user }
    #
    #   it 'redirects to categories_path' do
    #     get :new
    #     expect(response).to redirect_to(categories_path)
    #     expect(flash[:alert]).to eq('Only admins can perform that action')
    #   end
  end
end