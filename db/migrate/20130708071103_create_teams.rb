class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :team_name
      t.text :team_description
      t.string :team_type
      t.string :status
      t.timestamps
    end
  end
end
