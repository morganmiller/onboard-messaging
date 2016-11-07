require 'rails_helper'

RSpec.describe SmsMessage, type: :model do
  let(:account) { Account.create(name: 'OnboardIQ') }
  let(:user)    { account.users.create(name: 'Morgan', email: 'm.miller722@gmail.com') }

  let(:user_sms)      { account.sms_messages.create(
                          user: user, from_number: "7274216505",
                          to_number: "8006927754",
                          body: "Hey, so is there any chance we can move that meeting to 10am?",
                          created_at: 5.days.ago)}
  let(:system_sms)    { account.sms_messages.create(
                          outbound: true, from_number: "4804331197",
                          to_number: "8006927753",
                          body: "This is a friendly reminder, respond YES or NO",
                          created_at: 3.days.ago)}
  let(:applicant_sms) { account.sms_messages.create(
                          from_number: "8006927754",
                          to_number: "7274216505",
                          body: "Who is this? Leave me alone!11",
                          created_at: 5.days.ago)}

  it { should belong_to(:account) }
  it { should validate_presence_of(:account) }

  it { should belong_to(:user) }

  it { should belong_to(:message_thread) }

  it 'triggers #assign_message_thread on create' do
    user
    sms = account.sms_messages.build(
      user: user, from_number: "7274216505",
      to_number: "8006927753",
      body: "Hey, so is there any chance we can move that meeting to 10am?",
      created_at: 5.days.ago)

    expect(sms).to receive(:assign_message_thread)
    sms.save
  end

  it 'assigns the correct message thread by applicant and account' do
    user
    thread1 = MessageThread.create(account_id: account.id, applicant_number: "8006927754")
    thread2 = MessageThread.create(account_id: account.id, applicant_number: "8006927753")

    expect(user_sms.message_thread).to eq(thread1)
    expect(system_sms.message_thread).to eq(thread2)
    expect(applicant_sms.message_thread).to eq(thread1)
  end

  it 'knows the account applicant\'s phone number' do
    user
    expect(user_sms.applicant_number).to eq(user_sms.to_number)
    expect(system_sms.applicant_number).to eq(system_sms.to_number)
    expect(applicant_sms.applicant_number).to eq(applicant_sms.from_number)
  end

  it 'knows whether a message originated internally' do
    user
    expect(user_sms.originated_internally?).to be(true)
    expect(system_sms.originated_internally?).to be(true)
    expect(applicant_sms.originated_internally?).to be(false)
  end

  it 'knows whether a message was sent by a user' do
    user
    expect(user_sms.sent_by_user?).to be(true)
    expect(system_sms.sent_by_user?).to be(false)
    expect(applicant_sms.sent_by_user?).to be(false)
  end

  it 'knows whether a message was sent by the system' do
    user
    expect(user_sms.sent_by_system?).to be(false)
    expect(system_sms.sent_by_system?).to be(true)
    expect(applicant_sms.sent_by_system?).to be(false)
  end

end
