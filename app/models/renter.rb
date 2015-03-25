class Renter < ActiveRecord::Base
  before_save { |user| user.email = email.downcase }
  validates :email, uniqueness: true

  def display_name
    return first_name.titleize + ' ' + last_name[0].capitalize
  end
end
