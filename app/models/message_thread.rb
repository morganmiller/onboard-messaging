class MessageThread < ActiveRecord::Base
  belongs_to :account

  has_many :sms_messages, -> { order(created_at: :desc) }

  scope :sorted, -> { order(created_at: :desc) }
end
