import gleam/int
import gleam/io
import gleam/string

pub fn main() {
  io.println("Hello from bencode!")
}

pub type Data {
  S(x: String)
  I(x: Int)
  L(x: List(Data))
}

pub fn encode(data: Data) -> Result(String, Nil) {
  case data {
    I(x) -> encode_int(x)
    S(x) -> encode_string(x)
    _ -> "Suckk ass boomer"
  }
  |> Ok
}

fn encode_int(x: Int) -> String {
  "i" <> int.to_string(x) <> "e"
}

fn encode_string(x: String) -> String {
  int.to_string(string.length(x)) <> ":" <> x
}
