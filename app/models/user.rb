class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable

  has_many :rides
  has_many :attractions, through: :rides
  validates_presence_of :password, :on => :create
  # has_secure_password
  before_save :set_default_values

  def set_default_values
    self.nausea = 0 if !self.nausea
    self.happiness = 0 if !self.happiness
    self.tickets = 0 if !self.tickets
  end

  def mood
    self.happiness > self.nausea ? "happy" : "sad" 
  end

  def ride(attraction)
    self.update_tickets(attraction)
    self.update_nausea(attraction)   
    self.update_happiness(attraction) 
  end

  def update_tickets(attraction)
    new_tickets = self.tickets - attraction.tickets
    self.update_attribute(:tickets, new_tickets)
  end

  def update_happiness(attraction)
    new_happiness = self.happiness + attraction.happiness_rating
    self.update_attribute(:happiness, new_happiness)
  end

  def update_nausea(attraction)
    new_nausea = self.nausea + attraction.nausea_rating
    self.update_attribute(:nausea, new_nausea)
  end
end
