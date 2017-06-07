class CreateAttendanceTables < ActiveRecord::Migration[5.0]
  def change
    create_table :attendance_tables do |t|
      t.integer :attendee_id
      t.integer :attended_event_id

      t.timestamps
    end
  end
end
