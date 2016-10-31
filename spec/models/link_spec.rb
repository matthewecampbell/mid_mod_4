require 'rails_helper'

RSpec.describe Link, type: :model do
  it { should respond_to(:url) }
  it { should respond_to(:title) }

  it { should belong_to(:user) }

end
