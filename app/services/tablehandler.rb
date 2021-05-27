class TableHandler
  attr_reader :header, :rows

  def initialize(header:, rows:)
    @header = header
    @rows = rows
  end

  def self.create_table(header, rows)
    Terminal::Table.new :headings => header, :rows => rows
  end
end