class Manager < ActiveRecord::Base
  has_secure_password
  before_save { |user| user.email = email.downcase }
  validates :email, uniqueness: true

  def display_name
    return first_name.titleize + ' ' + last_name[0].capitalize
  end
end
