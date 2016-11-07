class SmsMessagesController < ApplicationController
  def index
    @message_threads = @account.message_threads.sorted.includes([:account, sms_messages: :user]).paginate(:page => params[:page], :per_page => 7)
  end
end
