require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'User model' do

    it "should be valid " do
      expect(build(:user)).to be_valid
    end

    it "should store into db" do
      expect(create(:user)).to_not be_nil
    end

    it "should invalid without a email" do
      expect(build(:user, email: '')).to_not be_valid
    end

    it "should invalid without a password" do
      expect(build(:user, password: '')).to_not be_valid
    end

    it "should invalid without a name" do
      expect(build(:user, name: '')).to_not be_valid
    end
  end
end
