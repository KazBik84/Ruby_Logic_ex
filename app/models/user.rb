class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

validates :username, :f_name, :l_name, :validity_date, presence: true
# email proper format and uniquness is validated by devise
validates :email, format: { with: /[a-z]+/ }
validates :username, format: { with: /\b[a-z]+\b/ }, length: { is: 8 }, uniqueness: true
validates :f_name, :l_name, format: { with: /\A([A-Z][a-z]*)+( [A-Z][a-z]*)*\z/ }
validates_date :validity_date, after: Date.today


  private

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_hash).first
    end
  end  
end
