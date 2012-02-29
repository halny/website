class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name,
    :lastname, :telephone, :is_student, :is_member

  has_many :race_registrations

  def grant_admin!
    update_attribute(:is_admin, true)
  end

  def revoke_admin!
    update_attribute(:is_admin, false)
  end
end
