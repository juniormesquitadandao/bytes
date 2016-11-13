require "byebug"

require_relative "bytes"

def compress
  bytes = read_bytes_file

  symbols = read_symbols
  products_hash = read_products_hash

  result = bytes.each_slice(2).map do |bytes_two|
    if bytes_two.size == 2
      product = products_hash[bytes_two.join(',')]
      symbol = symbols[product]
    else
      symbol = ";#{bytes_two.first.to_s 36};"
    end

    symbol
  end

  result

  IO.write "#{ARGV.first}.bytes", result.join
end

puts "compress"
compress
