class Review < ActiveRecord::Base
  validates :product_id, :user_id, :description, :rating, presence: true
  validates :rating, inclusion: 1..5

  belongs_to :product
  
end
