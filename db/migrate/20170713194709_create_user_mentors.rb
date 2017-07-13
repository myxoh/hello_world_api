class CreateUserMentors < ActiveRecord::Migration[5.1]
  def change
    create_table :user_mentors do |t|
      t.references :mentor, foreign_key: { to_table: :users }
      t.references :mentee, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
