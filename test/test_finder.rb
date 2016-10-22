# frozen_string_literal: true

require 'minitest/autorun'
require 'fusor'

class TestFinder < Minitest::Test
  def setup
    @query = 'Ivan Ivanovich'
  end

  def test_finder_creation
    f = Fusor::Finder.new
    assert_equal f.status, :ready
  end

  def test_finder_google
    f = Fusor::Finder.new
    assert_match(query, f.google(@query).title)
  end

  def test_finder_mailru
    f = Fusor::Finder.new
    assert_match(query, f.mail(@query).title)
  end

  def test_finder_bing
    f = Fusor::Finder.new
    assert_match(query, f.bing(@query).title)
  end

  def test_finder_yandex
    f = Fusor::Finder.new
    uri = URI(f.yandex(@query).uri)
    assert_match(query, CGI.parse(uri.query)['text'].first)
  end
end
