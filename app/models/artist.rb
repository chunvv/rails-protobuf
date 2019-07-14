require 'artist_message_pb'
require 'artist_collection_message_pb'

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

  ###
  # Encode all models to ArtistCollectionMessage
  # protobuf message
  def self.serialize_all
    message = ArtistCollectionMessage.new(
      :artists => Artist.all.map { |a|
        a.to_message
      }
    )
    ArtistCollectionMessage.encode(message)
  end

  ###
  # Decode a ArtistCollectionMessage protobuf
  # to a collection of Artist models
  def self.unserialize_all(data)
    message = ArtistCollectionMessage.decode(data)
    message.artists.map { |a|
      Artist.from_message(a)
    }
  end
end
