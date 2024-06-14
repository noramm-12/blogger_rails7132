require 'rails_helper'

RSpec.describe Category, type: :model do
  let!(:category) {FactoryBot.create(:category)}
  # let!(:category) {create(:category)}
  # let!(:category) {Category.create(name: 'Fashion')}

  context 'associations' do
    it {should have_many(:article_categories)}
    it {should have_many(:articles).through(:article_categories)}
  end

  context 'validations' do
    it 'category should be valid' do
      expect(category).to be_valid
    end
    it { should validate_presence_of(:name) }
    it 'name should be unique' do
      category2 = Category.create(name:"Fashion")
      expect(category2).to_not be_valid
    end
    it { should validate_length_of(:name)
                  .is_at_least(3).is_at_most(25)}
  end
end
