class Manager < ActiveRecord::Base
  has_secure_password
  before_save { |user| user.email = email.downcase }
  validates :email, uniqueness: true

  has_many :events

  def display_name
    # return first_name.titleize + ' ' + last_name[0].capitalize
    # first_name.titleize + ' ' + last_name.titleize
    first_name + ' ' + last_name
  end
end
