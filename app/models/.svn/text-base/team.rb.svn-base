class Team < ActiveRecord::Base
  attr_accessible :team_name,:team_description,:team_type, :status
    
  # Relations
  has_many :team_employees
  has_many :employees, :through => :team_employees
  
  # Validations
  validates :team_name, :length => {:maximum => 50}, :presence => { :message => "Team Name Required" }
  validates :team_name, :uniqueness => true
  validates :team_description, :length => {:maximum => 400}, :presence => { :message => "Description Required" }
  validates :team_type, :length => {:maximum => 50}, :presence => { :message => "Team Type Required" }  

end
