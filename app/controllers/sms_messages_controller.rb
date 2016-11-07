class SmsMessagesController < ApplicationController
  def index
    @message_threads = @account.message_threads.sorted.includes([:account, sms_messages: :user]).all
  end
end
