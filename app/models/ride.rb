class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    error_messages = ["Sorry."]
    if !user_has_enough_tickets? 
      error_messages << "You do not have enough tickets to ride the #{attraction.name}."
    end
    if !user_is_tall_enough? 
      error_messages << "You are not tall enough to ride the #{attraction.name}."
    end 
    return error_messages.join(" ") if !user_can_ride? 

    user.ride(attraction)
    return "Thanks for riding the #{attraction.name}!"
  end

  def self.find_or_create_by_user_and_attraction(user, attraction)
    ride = self.where(user_id: user.id).where(attraction_id: attraction.id).first
    if !ride
      ride = Ride.create(user_id: user.id, attraction_id: attraction.id)
    end
    return ride
  end

  private
  def user_can_ride?
    user_is_tall_enough? && user_has_enough_tickets?
  end

  def user_is_tall_enough?
    user.height >= attraction.min_height
  end

  def user_has_enough_tickets?
    user.tickets >= attraction.tickets
  end

end
