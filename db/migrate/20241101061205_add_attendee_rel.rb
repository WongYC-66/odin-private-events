class AddAttendeeRel < ActiveRecord::Migration[7.2]
  def change
    create_table :event_attendings do |t|
      # t.references :event, foreign_key: { to_table: :attended_events }
      # t.references :user, foreign_key: { to_table: :attendees }
      t.belongs_to :attended_event, foreign_key: { to_table: :events }
      t.belongs_to :attendee, foreign_key: { to_table: :users }
    end
  end
end
