class CreateSubMenuCourseCriteria < ActiveRecord::Migration
  def change
    create_table :sub_menu_course_criteria do |t|
      t.integer :sub_menu_id, :null => false
      t.integer :course_id, :null => false
      t.integer :min_qty
      t.integer :max_qty
      t.timestamps
    end
  end
end
