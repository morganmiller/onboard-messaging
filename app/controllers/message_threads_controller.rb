class MessageThreadsController < ApplicationController

  def update
    @message_thread = MessageThread.find(params[:id])
    if @message_thread.update(message_thread_params)
       render partial: "sms_messages/message_thread", locals: {message_thread: @message_thread}
    else
    end
  end

private
  def message_thread_params
    params.require(:message_thread).permit(:unread)
  end
end
