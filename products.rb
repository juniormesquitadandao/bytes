PRODUCTS_BYTES = 65536

def generate_products
  bytes = (-128..127).to_a
  puts "bytes: #{bytes.size}"

  products = bytes.product(bytes).to_a
  puts "products: #{products.size}"
  raise "expected: #{PRODUCTS_BYTES}" if products.size != PRODUCTS_BYTES

  IO.write 'products.json', products
  puts "generated: products.json"
end

generate_products