class Goal < ActiveRecord::Base
  attr_accessible :name, :privacy, :completed, :user_id

  validates :name, :privacy, :user_id, presence: true
  before_validation
  belongs_to :user
end
