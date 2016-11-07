require 'rails_helper'

RSpec.describe MessageThread, type: :model do
  it { should belong_to(:account) }

  it { should have_many(:sms_messages) }
end
