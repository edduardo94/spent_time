class Project < ApplicationRecord
  has_and_belongs_to_many :users, dependent: :delete_all
end
