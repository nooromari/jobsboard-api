require 'rails_helper'

RSpec.describe User, type: :model do
  # ensure User model has a 1:m relationship with the Application model
  it { should have_many(:applications) }
  # ensure email and password_digest are present before save
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
end
