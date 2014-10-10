defmodule FibinacciSequence do
  def next_number(_, _, 0), do: IO.puts "fin"
  def next_number(number_one, number_two, to_the_nth) do
    number_three = number_one + number_two 
    IO.puts number_three = number_one + number_two
    next_number(number_two, number_three, to_the_nth - 1)
  end
  
  def run(to_the_nth), do: next_number(0, 1, to_the_nth)
end

FibinacciSequence.run(10000)