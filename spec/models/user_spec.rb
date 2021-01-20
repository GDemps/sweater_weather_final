require 'rails_helper'

RSpec.describe User do
  describe 'Validations' do
    it {should validate_presence_of :email}
    it {should validate_uniqueness_of :email}
    it 'has a unique api_key' do
      user1 = create(:user)
      user2 = create(:user)

      expect(user1.api_key).to_not eq(user2.api_key)
    end
  end
end
