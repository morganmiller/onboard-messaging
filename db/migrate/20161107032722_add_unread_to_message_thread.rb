class AddUnreadToMessageThread < ActiveRecord::Migration
  def change
    add_column :message_threads, :unread, :boolean, index: true, default: true
  end
end
