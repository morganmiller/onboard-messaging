class AddMessageThreadCountToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :message_threads_count, :integer, index: true, default: 0
  end
end
