class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :login
      t.string :password_digest

      t.timestamps

      t.index ["email"], name: "index_users_on_email", unique: true
    end
  end
end
