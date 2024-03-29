class Account < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :users
  has_many :sms_messages
  has_many :message_threads
end
