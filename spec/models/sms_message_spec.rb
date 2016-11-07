require 'rails_helper'

RSpec.describe SmsMessage, type: :model do
  it { should belong_to(:account) }
  it { should validate_presence_of(:account) }

  it { should belong_to(:user) }

  it { should belong_to(:message_thread) }
end
