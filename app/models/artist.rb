require 'artist_message_pb'

class Artist < ApplicationRecord
  has_many :venues

  # Create a model from a message object
  def self.from_message(message)
    Artist.new.tap do |a|
      a.id = message.id
      a.name = message.name
      a.bio = message.bio
      a.genre = message.genre
    end
  end

  # Create a message object from model
  def to_message
    ArtistMessage.new(
      :id => self.id,
      :name => self.name,
      :bio => self.bio,
      :genre => self.genre
    )
  end

  # Encode model data in protobuf format
  def serialize
    ArtistMessage.encode(self.to_message)
  end

  # Decode protobuf data and hydrate model
  def unserialize(data)
    message = ArtistMessage.decode(data)
    Artist.from_message(message)
  end
end
