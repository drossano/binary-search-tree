class Tree
  def initialize(array)
    @data = array.uniq.sort
  end
end