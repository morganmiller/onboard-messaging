class CreateMessageThreads < ActiveRecord::Migration
  def change
    create_table :message_threads do |t|
      t.string :applicant_number, index: true
      t.references :account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
