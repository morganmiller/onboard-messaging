class MessageThread < ActiveRecord::Base
  belongs_to :account

  has_many :sms_messages, -> { order(created_at: :asc) }, after_add: :set_unread_status

  scope :sorted, -> { order(created_at: :desc) }

  def set_unread_status(sms_message)
    update_attributes(unread: true)
  end

end
