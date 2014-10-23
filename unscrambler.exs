defmodule Unscrambler do
  
  def get_all_sorted_combinatins_of(letters), do: build_word_list( "", letters, [])

  def build_word_list( _, [], [] ),                   do: IO.puts "fin"
  def build_word_list( _, [], queue ),                do: reset(queue)
  def build_word_list( word, [ head | tail ], queue ) do
    IO.puts word<>head
    build_word_list( word, tail, to_queue(word<>head, tail, queue) )
  end

  def to_queue( _, [], queue ),         do: queue
  def to_queue( word, letters, queue ), do: queue++[ [word, letters] ]

  def reset( [head | tail] ), do: build_word_list( List.first(head), List.last(head), tail )

end

Unscrambler.get_all_sorted_combinatins_of(["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p"])
