require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:articles).dependent(:destroy) }

  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe '#author_of?' do
    it 'returns true when user is creator of the object' do
      user = create(:user)
      object = create(:article, user: user)

      expect(user.author_of?(object)).to be true
    end

    it 'returns false when user is not creator of the object' do
      user = create(:user)
      another_user = create(:user)
      another_object = create(:article, user: another_user)

      expect(user.author_of?(another_object)).to be false
    end
  end
end
