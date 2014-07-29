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

  def teardown
    IdeaStore.delete_all
  end

end
