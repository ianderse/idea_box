class Idea
  attr_accessor :title, :description, :id
  attr_reader   :likes

  def initialize(title, description)
    @title = title
    @description = description
    @likes = 0
  end

  def like!
    @likes +=1
  end

  def <=>(other)
    likes <=> other.likes
  end

  def new?
    !id
  end

end
