class AddMessageThreadToSmsMessage < ActiveRecord::Migration
  def change
    add_reference :sms_messages, :message_thread, index: true, foreign_key: true
  end
end
