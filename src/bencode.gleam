import gleam/int
import gleam/io
import gleam/list
import gleam/result
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
    L(l) -> encode_list(l)
  }
}

fn encode_int(x: Int) -> Result(String, Nil) {
  { "i" <> int.to_string(x) <> "e" }
  |> Ok
}

fn encode_string(x: String) -> Result(String, Nil) {
  { int.to_string(string.length(x)) <> ":" <> x }
  |> Ok
}

fn encode_list(list: List(Data)) -> Result(String, Nil) {
  list.map(list, encode)
  |> result.all
  |> result.map(fn(x) { "l" <> string.join(x, "") <> "e" })
}
