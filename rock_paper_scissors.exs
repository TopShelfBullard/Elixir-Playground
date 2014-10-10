defmodule RockPaperScissors do
  def get_player_pick({player_score, computer_score}) do
    parse_player_pick({player_score, computer_score, IO.gets(RockPaperScissors.Output.choices)})
  end

  def parse_player_pick({player_score, computer_score, "1\n"}), do: {player_score, computer_score, 1}
  def parse_player_pick({player_score, computer_score, "2\n"}), do: {player_score, computer_score, 2}
  def parse_player_pick({player_score, computer_score, "3\n"}), do: {player_score, computer_score, 3}
  def parse_player_pick({player_score, computer_score, _}) do
    RockPaperScissors.Output.error
    get_player_pick({player_score, computer_score})
  end

  def get_computer_pick({player_score, computer_score, player_pick}) do
    {player_score, computer_score, player_pick, AMB.Utilities.random_number(3)}
  end

  def get_result({player_score, computer_score, player_pick, computer_pick}) do
    {player_score, computer_score, player_pick, computer_pick, player_pick - computer_pick}
  end

  def adjust_score({player_score, computer_score, player_pick, computer_pick, result}) when result == 2 or result == -1 do
    {player_score, computer_score + 1, player_pick, computer_pick, "*** The computer won that round. ***"}
  end

  def adjust_score({player_score, computer_score, player_pick, computer_pick, result}) when result == 0 do
    {player_score, computer_score, player_pick, computer_pick, "*** That's a tie. ***"}
  end

  def adjust_score({player_score, computer_score, player_pick, computer_pick, _}) do
    {player_score + 1, computer_score, player_pick, computer_pick, "*** You won that round. ***"}
  end 
  
  def play_game({5, _}), do: RockPaperScissors.Output.player_ultimate_victory
  def play_game({_, 5}), do: RockPaperScissors.Output.computer_ultimate_victory
  def play_game({player_score, computer_score}) do
    get_player_pick({player_score, computer_score})
    |> get_computer_pick
    |> get_result
    |> adjust_score
    |> RockPaperScissors.Output.round_results
    |> play_game 
  end
end

defmodule RockPaperScissors.Output do
  def welcome_message, do: IO.puts "\n*** Welcome to Rock, Paper, Scissors. ***\n\t- First one to 5 wins. -\n"
  def choices, do: "Please choose 1, 2, or 3 and press enter: \n\t1 = rock\n\t2 = paper\n\t3 = scissors\n  : "
  def error, do: IO.puts "INVALID INPUT: Please choose again."
  def player_ultimate_victory, do: IO.puts "You won the game! Good Job, Buddy!\n"
  def computer_ultimate_victory, do: IO.puts "The computer just won the game. You aren't very good at this, are you?\n"

  def parse_choice(1), do: "ROCK"
  def parse_choice(2), do: "PAPER"
  def parse_choice(3), do: "SCISSORS"

  def round_results({player_score, computer_score, player_pick, computer_pick, round_winner}) do
    IO.puts "\nYou chose: #{parse_choice(player_pick)}\nThe computer chose #{parse_choice(computer_pick)}.\n"
    IO.puts round_winner
    IO.puts "\nThe score is now:\n\tYou = #{player_score}\n\tComputer = #{computer_score}\n"
    {player_score, computer_score}
  end
end

defmodule AMB.Utilities do
  def random_number(number) do
    :random.seed(:erlang.now)
    :random.uniform(number)
  end
end

RockPaperScissors.Output.welcome_message
RockPaperScissors.play_game({0,0})