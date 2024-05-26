import bencode as b
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn hello_world_test() {
  1
  |> should.equal(1)
}

//TODO: An integer is encoded as i<integer encoded in base ten ASCII>e. Leading zeros are not allowed (although the number zero is still represented as "0"). Negative values are encoded by prefixing the number with a hyphen-minus. The number 42 would thus be encoded as i42e, 0 as i0e, and -42 as i-42e. Negative zero is not permitted.
pub fn int_encode_test() {
  42
  |> b.I()
  |> b.encode()
  |> should.be_ok()
  |> should.equal("i42e")

  0
  |> b.I()
  |> b.encode()
  |> should.be_ok()
  |> should.equal("i0e")

  -42
  |> b.I()
  |> b.encode()
  |> should.be_ok()
  |> should.equal("i-42e")
}

//TODO: A byte string (a sequence of bytes, not necessarily characters) is encoded as <length>:<contents>. The length is encoded in base 10, like integers, but must be non-negative (zero is allowed); the contents are just the bytes that make up the string. The string "spam" would be encoded as 4:spam. The specification does not deal with encoding of characters outside the ASCII set; to mitigate this, some BitTorrent applications explicitly communicate the encoding (most commonly UTF-8) in various non-standard ways. This is identical to how netstrings work, except that netstrings additionally append a comma suffix after the byte sequence.
pub fn byte_string_encode_test() {
  "spam"
  |> b.S()
  |> b.encode()
  |> should.be_ok()
  |> should.equal("4:spam")
}

//TODO: A list of values is encoded as l<contents>e . The contents consist of the bencoded elements of the list, in order, concatenated. A list consisting of the string "spam" and the number 42 would be encoded as: l4:spami42ee. Note the absence of separators between elements, and the first character is the letter 'l', not digit '1'.
pub fn list_encode_test() {
  [b.S("spam"), b.I(42)]
  |> b.L()
  |> b.encode()
  |> should.be_ok()
  |> should.equal("l4:spami42ee")
}
