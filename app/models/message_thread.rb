class MessageThread < ActiveRecord::Base
  belongs_to :account

  has_many :sms_messages
end
