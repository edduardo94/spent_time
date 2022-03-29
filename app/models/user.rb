class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email, :password_digest
  has_and_belongs_to_many :projects, dependent: :delete_all
  has_many :spent_hours

  def as_json(options = {})
    super(options.merge({ except: [:password_digest] }))
  end
end
