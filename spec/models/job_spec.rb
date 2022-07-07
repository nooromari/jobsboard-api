# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Job, type: :model do
  it { should have_many(:applications).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
end
