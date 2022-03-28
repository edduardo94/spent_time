class CreateProjectsUsersJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_table :projects_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :project
    end
  end
end
