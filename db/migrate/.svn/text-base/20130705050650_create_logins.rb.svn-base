class CreateLogins < ActiveRecord::Migration
  def change
    create_table :logins do |t|
      
      t.string    :user_name, :limit =>256
      t.string    :password_digest
      t.integer   :attempts, :default => 0
      t.integer   :first_time_login, :default => 0
      t.datetime  :login_date
      t.boolean   :is_password_change, :default => false
      t.string    :question_one
      t.string    :answer_one
      t.string    :question_two
      t.string    :answer_two

      t.timestamps
    end
  end
end
