defmodule FizzBuzz do
  def get_remainders(n), do: {rem(n,3), rem(n,5), n}

  def print_result({0, 0, _}), do: IO.puts "FizzBuzz"   
  def print_result({0, _, _}), do: IO.puts "Fizz"
  def print_result({_, 0, _}), do: IO.puts "Buzz"
  def print_result({_, _, n}), do: IO.puts "#{n}"
  
  def fizz_buzz(101), do: IO.puts "Fin"
  def fizz_buzz(number) do
    number
    |> get_remainders
    |> print_result
    fizz_buzz(number + 1)
  end
end

FizzBuzz.fizz_buzz 1
