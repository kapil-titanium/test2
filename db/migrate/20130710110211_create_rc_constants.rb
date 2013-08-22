class CreateRcConstants < ActiveRecord::Migration
  def change
    create_table :rc_constants do |t|
      t.string :constant_name
      t.string :constant_type
      t.timestamps
    end
  end
end
