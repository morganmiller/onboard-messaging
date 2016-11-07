class MessageThread < ActiveRecord::Base
  belongs_to :account

  has_many :sms_messages, -> { order(created_at: :asc) }, after_add: :set_unread_status

  after_save :count_unread_threads

  scope :sorted, -> { order(created_at: :asc) }

  def set_unread_status(sms_message)
    update_attributes(unread: true)
  end

  def count_unread_threads
    if unread_changed?
      value = unread ? 1 : -1
      new_count = account.message_threads_count + value
      account.update_attributes(message_threads_count: new_count)
    end
  end

end
