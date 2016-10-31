require 'rails_helper'

RSpec.describe User, type: :model do
  it { should respond_to(:email) }
  it { should respond_to(:password) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  it { should validate_uniqueness_of(:email) }

  it { should have_many(:links) }

  scenario 'user is valid only with all attributes' do
    user = User.new(email: 'clay')
    user_1 = User.new(password: 'aaron')
    user_2 = User.new(email: 'aaron@packers.com', password: 'packersrule')
    expect(user.save).to eq false
    expect(user_1.save).to eq false
    expect(user_2.save).to eq true
  end
end
