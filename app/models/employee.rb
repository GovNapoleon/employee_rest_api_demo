class Employee < ApplicationRecord
  belongs_to :country
  belongs_to :department
end
