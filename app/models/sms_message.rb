class SmsMessage < ActiveRecord::Base
  belongs_to :account
  validates :account, presence: true

  belongs_to :message_thread

  belongs_to :user

  after_create :assign_message_thread

  scope :unread, -> { where(unread: true) }
  scope :outbound, -> { where(outbound: true) }
  scope :sorted, -> { order(created_at: :desc) }

  def assign_message_thread
   m = MessageThread.find_or_create_by(applicant_number: applicant_number, account: self.account)
   m.sms_messages << self
  end

  def applicant_number
    if originated_internally?
      to_number
    else
      from_number
    end
  end

  def originated_internally?
    sent_by_user? || sent_by_system?
  end

  def sent_by_user?
    self.user_id.present?
  end

  def sent_by_system?
    self.outbound
  end

end
