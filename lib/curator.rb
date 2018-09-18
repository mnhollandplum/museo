require_relative './photograph'
require_relative './artist'
class Curator
    attr_reader :artists, :photographs
  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(photo)
    @photographs << Photograph.new(photo)
  end

  def add_artist(artist)
    @artists << Artist.new(artist)
  end

  def find_artist_by_id(id)
    @artists.find do |artist|
      artist.id == id
    end
  end

  def find_photograph_by_id(id)
    @photographs.find do |photograph|
      photograph.id == id
    end
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all do |photograph|
      photograph.artist_id == artist.id
    end
  end

  def artists_with_multiple_photographs
    ids = photos_by_artist_id.map do |id, photos|
        if photos.count > 1
          id
        end
      end.compact
    @artists.find_all do |artist|
      [artist.id] == ids
    end
  end

  def photos_by_artist_id
    @photographs.group_by do |photograph|
      photograph.artist_id
    end
  end

  def photographs_taken_by_artists_from(country)
    artists_id_by_country = @artists.map do |artist|
      if artist.country == country
        artist.id
      end
    end.compact
    artists_id_by_country.map do |id|
        find_photograph_by_artist_id(id)
    end.flatten
  end

  def find_photograph_by_artist_id(id)
    @photographs.find_all do |photo|
      photo.artist_id == id
    end
  end

end
