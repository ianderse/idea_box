require_relative 'test_helper'
require_relative '../lib/idea_store'

class IdeaStoreTest < Minitest::Test

  def test_save_and_retrieve_an_idea
    idea = Idea.new("celebrate", "with champagne")
    id   = IdeaStore.save(idea)
    assert_equal 1, IdeaStore.count

    idea = IdeaStore.find(id)
    assert_equal "celebrate", idea.title
    assert_equal "with champagne", idea.description
  end

  def test_save_and_retrieve_multiple_ideas
    idea1 = Idea.new("celebrate", "with champagne")
    id1   = IdeaStore.save(idea1)

    assert_equal 1, IdeaStore.count

    idea2 = Idea.new("dream", "of unicorns and rainbows")
    id2 = IdeaStore.save(idea2)

    assert_equal 2, IdeaStore.count

    found_idea1 = IdeaStore.find(id1)
    assert_equal "celebrate", found_idea1.title
    assert_equal "with champagne", found_idea1.description

    found_idea2 = IdeaStore.find(id2)
    assert_equal "dream", found_idea2.title
    assert_equal "of unicorns and rainbows", found_idea2.description
  end

  def test_update_idea
    idea = Idea.new("drink", "tomato juice")
    id = IdeaStore.save(idea)

    idea = IdeaStore.find(id)
    idea.title = "cocktails"
    idea.description = "spicy tomato juice with vodka"

    IdeaStore.save(idea)

    assert_equal 1, IdeaStore.count

    idea = IdeaStore.find(id)
    assert_equal "cocktails", idea.title
    assert_equal "spicy tomato juice with vodka", idea.description
  end

  def test_delete_an_idea
    id1 = IdeaStore.save Idea.new("song", "99 bottles of beer")
    id2 = IdeaStore.save Idea.new("gift", "micky mouse belt")
    id3 = IdeaStore.save Idea.new("dinner", "cheeseburger with bacon and avocado")

    assert_equal ["dinner", "gift", "song"], IdeaStore.all.map(&:title).sort
    IdeaStore.delete(id2)
    assert_equal ["dinner", "song"], IdeaStore.all.map(&:title).sort
  end

  def test_delete_the_last_idea
    id1 = IdeaStore.save Idea.new("song", "99 bottles of beer")

    IdeaStore.delete(id1)

    assert_equal [], IdeaStore.all
  end

  def test_edit_a_nonexistant_idea
    id1 = IdeaStore.save Idea.new("song", "99 bottles of beer")

    assert_equal "Idea doesn't exist", IdeaStore.find(3)
  end

  def teardown
    IdeaStore.delete_all
  end

end
