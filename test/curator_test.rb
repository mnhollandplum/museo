require 'minitest/autorun'
require 'minitest/pride'
require './lib/curator'

class CuratorTest < Minitest::Test
  def test_curator_exists
    curator = Curator.new
    assert_instance_of Curator, curator
  end

  def test_curator_starts_with_no_artists
    curator = Curator.new

    assert_equal [], curator.artists
  end

  def test_curator_starts_with_no_photographs
    curator = Curator.new

    assert_equal [], curator.photographs
  end

  def test_curator_can_add_photographs
    curator = Curator.new

    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }

    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)

    assert [photo_1, photo_2], curator.photographs

    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", curator.photographs.first.name
  end

  def test_curator_can_add_artists
    curator = Curator.new

    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }

    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)

    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }

    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    assert [artist_1, artist_2], curator.artists

    assert_instance_of Artist, curator.artists.first

    assert artist_1, curator.artists.first

    assert "Henri Cartier-Bresson",curator.artists.first.name

  end
end
