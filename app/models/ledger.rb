class Ledger < ActiveRecord::Base
  attr_accessible   :kitchen_id, :menu_id, :meal_category_id, :order_number, :sold_qty, :total_price, :sold_date
  # Relations
  belongs_to :kitchen
  belongs_to :menu
  belongs_to :meal_category
end
