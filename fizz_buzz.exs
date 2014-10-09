defmodule FizzBuzz do
  def get_remainders(n), do: {rem(n,3),rem(n,5),n}

  def fizz_buzz({0,0,_}), do: IO.puts "FizzBuzz"   
  def fizz_buzz({0,_,_}), do: IO.puts "Fizz"
  def fizz_buzz({_,0,_}), do: IO.puts "Buzz"
  def fizz_buzz({_,_,n}), do: IO.puts "#{n}"

  def count_up_to_100_starting_at(number) when number < 100 do
    number
    |> get_remainders
    |> fizz_buzz
    count_up_to_100_starting_at(number + 1)
  end

  def count_up_to_100_starting_at(number), do: IO.puts "Fin"
end

FizzBuzz.count_up_to_100_starting_at 1
