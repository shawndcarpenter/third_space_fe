class SearchResult
  attr_reader :id, :name, :address, :category

  def initialize(data)
    @id = data[:id]
    @name = data[:name]
    @address = data[:address]
    @category = data[:category]
  end
end