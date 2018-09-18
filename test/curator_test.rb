require 'minitest/autorun'
require 'minitest/pride'
require './lib/curator'
require 'pry'

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

  def test_curator_can_find_artist_by_id
    curator = Curator.new

    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"        }

    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
      }

    curator.add_artist(artist_1)

    curator.add_artist(artist_2)

    assert_instance_of Artist,
    curator.find_artist_by_id("1")

    assert artist_1, curator.find_artist_by_id("1")

    assert_equal "Henri Cartier-Bresson", curator.find_artist_by_id("1").name
  end

  def test_curator_can_find_photograph_by_id
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

    assert_instance_of Photograph, curator.find_photograph_by_id("2")

    assert photo_2, curator.find_photograph_by_id("2")

    assert_equal "1941", curator.find_photograph_by_id("2").year
  end

  def test_curator_can_find_photographs_by_artist
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
    photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }

    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)

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
    artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)

    diane_arbus = curator.find_artist_by_id("3")

    assert [photo_3, photo_4], curator.find_photographs_by_artist(diane_arbus)

    assert_equal "Identical Twins, Roselle, New Jersey", curator.find_photographs_by_artist(diane_arbus).first.name
  end

  def test_curator_can_find_artists_with_multiple_photographs
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
    photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }

    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)

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
    artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)

    diane_arbus = curator.find_artist_by_id("3")

    assert_equal "1", curator.photos_by_artist_id.first[0]

    assert_instance_of Artist, curator.artists_with_multiple_photographs.first

    assert_equal "Diane Arbus", curator.artists_with_multiple_photographs.first.name

    assert_equal 1, curator.artists_with_multiple_photographs.length

    assert_equal diane_arbus, curator.artists_with_multiple_photographs.first
  end

  def test_curator_can_find_photographs_taken_by_artists_from_a_country
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
    photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }

    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)

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
    artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)

    assert_equal "Moonrise, Hernandez", curator.photographs_taken_by_artists_from("United States").first.name

    assert_equal "Child with Toy Hand Grenade in Central Park", curator.photographs_taken_by_artists_from("United States").last.name

    assert_equal [], curator.photographs_taken_by_artists_from("Argentina")





  end
end
