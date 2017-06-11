require 'rails_helper'

# Test suite for the Post model
RSpec.describe Post, type: :model do
  # Validation tests
  # ensure columns title and user are present before saving
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:user) }
end
