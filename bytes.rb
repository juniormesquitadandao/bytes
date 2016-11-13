require "json"

def read_bytes_file
  lines = IO.readlines ARGV.first
  bytes = lines.map!(&:bytes).flatten!
  bytes
end

def read_symbols
  lines = IO.readlines 'symbols.json'
  symbols = JSON.load lines.first
  symbols
end

def read_products
  lines = IO.readlines 'products.json'
  products = JSON.load lines.first
  products
end

def read_symbols_hash
  symbols_hash = read_symbols
  symbols_hash = Hash[ symbols_hash.each_with_index.map { |value, index| [value, index] } ]
  symbols_hash
end

def read_products_hash
  products_hash = read_products
  products_hash = Hash[ products_hash.each_with_index.map { |value, index| [value.join(','), index] } ]
  products_hash
end