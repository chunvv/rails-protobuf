class ArtistsController < ApplicationController
  before_action :find_artist, only: [:show]

  def show
    send_data @artist.serialize
  end

  def find_artist
    @artist = Artist.find params[:id]
  end
end
