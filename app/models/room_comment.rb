class RoomComment < ApplicationRecord
  belongs_to :account
  belongs_to :room
  belongs_to :user

  CATEGORIES = {
    'There is a fault with something in this room': 'fault',
    'This room is untidy': 'untidy',
    'This room needs more facilities': 'factilities',
    'I love this room - just wanted to say thanks': 'thanks'
  }
end
