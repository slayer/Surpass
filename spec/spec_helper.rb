require "lib/surpass"

include Utilities

class Array
  def to_bin
    hex_array_to_binary_string(self)
  end
end

