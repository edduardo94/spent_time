class CreateSpentHours < ActiveRecord::Migration[7.0]
  def change
    create_table :spent_hours do |t|
      t.timestamp :started_at
      t.timestamp :ended_at

      t.belongs_to :user
      t.belongs_to :project
    end
  end
end
