require 'minitest/autorun'
require 'fusor'

class TestFinder < Minitest::Test
  def test_finder_creation
    f = Fusor::Finder.new
    assert_equal f.status, :ready
  end

  def test_finder_google
    f = Fusor::Finder.new
    query = "Ivan Ivanovich"
    assert_match(query, f.google(query).title)
  end

  def test_finder_mailru
    f = Fusor::Finder.new
    query = "Ivan Ivanovich"
    assert_match(query, f.mail(query).title)
  end

  def test_finder_bing
    f = Fusor::Finder.new
    query = "Ivan Ivanovich"
    assert_match(query, f.bing(query).title)
  end

  def test_finder_yandex
    f = Fusor::Finder.new
    query = "Ivan Ivanovich"
    assert_match(query, f.yandex(query).title)
  end
end