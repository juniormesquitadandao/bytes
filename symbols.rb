RESERVED_UTF8_CHARS = 12
UNKNOW_UTF8_CHARS = 1932
UTF8_CHARS = 63604
PRODUCTS_BYTES = 65536

def generate_symbols
  reserved_chars = ["\a", "\b", "\t", "\n", "\v", "\f", "\r", "\"", "'", " ", ",", ";"]
  puts "reserved chars: #{reserved_chars.size}"
  raise "expected: #{RESERVED_UTF8_CHARS}" if reserved_chars.size != RESERVED_UTF8_CHARS

  unknown_utf8_chars = (0..(UNKNOW_UTF8_CHARS - 1)).map{|u| ",#{u.to_s 36},"}.to_a
  puts "unknown utf8 chars: #{unknown_utf8_chars.size}"
  raise "expected: #{UNKNOW_UTF8_CHARS}" if unknown_utf8_chars.size != UNKNOW_UTF8_CHARS

  bytes_one = (0..255).to_a
  utf8_chars = bytes_one.map { |b| [b].pack('c*').force_encoding('utf-8') }
  utf8_chars_with_one_byte = utf8_chars.select { |c| c.size == 1 }.to_a
  puts "utf8 chars with one byte: #{utf8_chars_with_one_byte.size}"

  bytes_two = bytes_one.product(bytes_one).lazy
  utf8_chars = bytes_two.map { |b| b.pack('c*').force_encoding('utf-8') }
  utf8_chars_with_two_bytes = utf8_chars.select { |c| c.size == 1 }.to_a
  puts "utf8 chars with two bytes: #{utf8_chars_with_two_bytes.size}"

  bytes_three = bytes_one.product(bytes_one, bytes_one).lazy
  utf8_chars = bytes_three.map { |b| b.pack('c*').force_encoding('utf-8') }
  utf8_chars_with_three_bytes = utf8_chars.select { |c| c.size == 1 }.to_a
  puts "utf8 chars with three bytes: #{utf8_chars_with_three_bytes.size}"

  utf8_chars = (utf8_chars_with_one_byte + utf8_chars_with_two_bytes + utf8_chars_with_three_bytes - reserved_chars)
  puts "utf8 chars: #{utf8_chars.size}"
  raise "expected: #{UTF8_CHARS}" if utf8_chars.size != UTF8_CHARS

  symbols = (unknown_utf8_chars + utf8_chars).uniq.compact
  puts "symbols: #{symbols.size}"
  raise "expected: #{PRODUCTS_BYTES}" if symbols.size != PRODUCTS_BYTES

  IO.write 'symbols.json', symbols
  puts "generated: symbols.json"
end

generate_symbols