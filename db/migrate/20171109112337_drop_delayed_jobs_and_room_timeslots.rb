class DropDelayedJobsAndRoomTimeslots < ActiveRecord::Migration[5.0]
  def change
    drop_table :delayed_jobs
    drop_table :room_timeslots
  end
end
