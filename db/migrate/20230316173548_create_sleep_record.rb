class CreateSleepRecord < ActiveRecord::Migration[7.0]
  def change
    create_table :sleep_records do |t|
      t.datetime :start_time, index: true
      t.datetime :end_time

      t.integer :duration, index: true

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
