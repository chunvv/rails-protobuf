class Venue < ApplicationRecord
  belongs_to :artist
  belongs_to :location

  def to_message
    VenueMessage.new(
      :id => self.id,
      :artist => self.artist.to_message,
      :location => self.location.to_message,
      :venue_date => self.venue_date.to_s
    )
  end

  def encode
    VenueMessage.encode(self.to_message)
  end
end
