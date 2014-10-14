defmodule RockPaperScissors do
  def get_picks({scores}), do: {scores, [ get_player_pick, get_computer_pick ]}

  def get_player_pick, do: get_player_pick(RockPaperScissors.Output.player_choices)
  def get_player_pick("1\n"), do: 1
  def get_player_pick("2\n"), do: 2
  def get_player_pick("3\n"), do: 3
  def get_player_pick(_),        do: get_player_pick(RockPaperScissors.Output.player_choices_with_error)

  def get_computer_pick do
    :random.seed(:erlang.now)
    :random.uniform(3)
  end

  def calculate_result({scores, picks}), do: {scores, picks, List.first(picks) - List.last(picks)}

  def adjust_score({scores, picks, 0}),   do: {scores, picks, "*** That's a tie. ***"}
  def adjust_score({scores, picks, 2}),   do: {[List.first(scores), List.last(scores) + 1], picks, "*** The computer won that round. ***"}
  def adjust_score({scores, picks, -1}), do: {[List.first(scores), List.last(scores) + 1], picks, "*** The computer won that round. ***"}
  def adjust_score({scores, picks, _}),   do: {[List.first(scores) + 1, List.last(scores)], picks, "*** You won that round. ***"}
  
  def play_game({[5, _], message}), do: RockPaperScissors.Output.player_ultimate_victory(message)
  def play_game({[_, 5], message}), do: RockPaperScissors.Output.computer_ultimate_victory(message)
  def play_game({scores, message}) do
    RockPaperScissors.Output.round_data(message)
    get_picks({scores})
    |> calculate_result
    |> adjust_score
    |> RockPaperScissors.Output.round_results
    |> play_game 
  end

  def start, do: play_game({[0, 0], RockPaperScissors.Output.welcome_message})   
end

defmodule RockPaperScissors.Output do
  def welcome_message, do: "\n*** Welcome to Rock, Paper, Scissors. ***\n\t- First one to 5 wins. -\n"
  def round_data(message), do: IO.puts message

  def player_choices,                   do: IO.gets(choices)
  def player_choices_with_error, do: IO.gets("#{input_error} \n #{choices}")
  def choices, do: "Please choose 1, 2, or 3 and press enter: \n\t1 = rock\n\t2 = paper\n\t3 = scissors\n  : "
  def input_error, do: "INVALID INPUT: Please choose again."

  def round_results({scores, picks, result}), do: {scores, "\n #{round_picks(picks)} \n #{result} \n #{round_scores(scores)}"} 
  def round_picks(picks), do: "\nYou chose: #{parse_choice(List.first(picks))}\nThe computer chose #{parse_choice(List.last(picks))}.\n"  
  def round_scores(scores), do: "\nThe score is now:\n\tYou = #{List.first(scores)}\n\tComputer = #{List.last(scores)}\n"

  def parse_choice(1), do: "ROCK"
  def parse_choice(2), do: "PAPER"
  def parse_choice(3), do: "SCISSORS"

  def player_ultimate_victory(message), do: IO.puts "\n #{(message)} \n You won the game! Good Job, Buddy!\n"
  def computer_ultimate_victory(message), do: IO.puts "\n #{(message)} \n The computer just won the game. You aren't very good at this, are you?\n"
end

RockPaperScissors.start
