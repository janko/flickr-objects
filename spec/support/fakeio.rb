require "forwardable"
require "stringio"

class FakeIO
  def initialize(content)
    @io = StringIO.new(content)
  end

  extend Forwardable
  delegate [:read, :eof?, :size, :rewind, :close] => :@io
end
