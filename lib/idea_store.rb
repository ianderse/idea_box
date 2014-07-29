class IdeaStore

  def self.all
    @all
  end

  def self.delete(id)
    @all.delete_at(id - 1)
  end

  def self.save(idea)
    @all ||= []
    all << idea if new?(idea)
    id(idea)
  end

  def self.new?(idea)
    idea.id = next_id if idea.new?
  end

  def self.count
    all.count
  end

  def self.find(id)
    all.find { |i| i.id == id }
  end

  def self.id(idea)
    idea.id
  end

  def self.next_id
    count + 1
  end

  def self.delete_all
    @all = []
  end

end
