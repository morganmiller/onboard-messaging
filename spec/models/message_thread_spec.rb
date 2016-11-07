require 'rails_helper'

RSpec.describe MessageThread, type: :model do
  let(:account) { Account.create(name: 'OnboardIQ') }
  let(:user)    { account.users.create(name: 'Morgan', email: 'm.miller722@gmail.com') }
  let(:thread)  { MessageThread.create(applicant_number: "8006927754", account_id: account.id, unread: false) }

  let(:user_sms)      { account.sms_messages.create(
                          user: user, from_number: "7274216505",
                          to_number: "8006927754",
                          body: "Hey, so is there any chance we can move that meeting to 10am?",
                          created_at: 5.days.ago)}

  it { should belong_to(:account) }

  it { should have_many(:sms_messages) }

  it 'sets its unread status to \'true\' after adding an sms message' do
    expect(thread.unread).to be(false)
    user_sms
    thread.reload
    expect(thread.unread).to be(true)
  end
end
