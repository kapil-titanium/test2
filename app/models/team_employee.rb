class TeamEmployee < ActiveRecord::Base
  attr_accessible :team_id, :employee_id
  
  # Relations
  belongs_to :team
  belongs_to :employee
  
  # Validations
  validates :team_id, :employee_id, :presence => true
end
