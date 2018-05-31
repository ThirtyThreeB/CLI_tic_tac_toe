class TicTacToe
	
	WINNING_PATTERNS = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]] 
	#attr_accessor :player_x, :player_o, :board, :current_player, :turn   
		
	def initialize 
		@score = {"X" => 0, "O" => 0}
		@round = 1
		start
	end

	def start
		@turn = 1
		@x_array = []
		@o_array = []
		@available_spaces = [*1..9]
		@board = "   1 2 3\n   4 5 6\n   7 8 9"

		if @round == 1
			puts @board
			puts "Here is the gameboard,\nyou'll play by entering the number\nthat corresponds with the space you choose"
			choose_team
		else 
			puts "Let's play round #{@round}"
		end	
		whose_turn
	end

	def choose_team 
		puts "You are the first player, do you want to be X's or O's ?"
		x_or_o
	end
		
	def x_or_o #validate choice of team either x or o
		team_choice = gets.chomp.upcase
		if team_choice == 'X' || team_choice == 'O' 
		  puts "Cool, you're on team #{team_choice}" 
		  @player_x, @player_o = 'X','O'	 
		else 
		 	puts "Dude, just type an x or an o" 
			x_or_o
		end
	end

	def whose_turn 

		if @round%2 == 1 # X's starting round when odd
			@first_player, @second_player = "X", "O"
		else
			@first_player, @second_player = "O", "X"
		end

		@turn%2 == 1 ? play_turn(@first_player) : play_turn(@second_player) #switches between player x and player o
	end

	def play_turn(player) 
		puts "Player #{player} goes first this round" unless @turn > 1
		puts "Player #{player} choose a space"
		puts @board
		val_choice(player)
		@turn += 1
		end_game 
		whose_turn
	end

	def val_choice(player) #make sure only 1-9, or whatever is left is entered
		choice = gets.chomp
		if @available_spaces.include?(choice.to_i) 
			@board = @board.gsub(choice, player)
			puts @board
			chosen_spaces(choice, player)
			@available_spaces.delete(choice.to_i)
		else
			puts "Nope, enter an available space.  Try again" 
			val_choice(player)
		end
	end

	def chosen_spaces(choice, player) #this chooses which array to push the chose space to depending on whose turn it is
		if player == "X"
			@x_array << choice.to_i
			else
			@o_array << choice.to_i
		end
	end

	def end_game #check to see if any winning patterns, or if board is full then 'tie'
		WINNING_PATTERNS.each do |pattern|
			if pattern- @x_array == []
		 		puts "X wins!" 
		 		@score["X"] += 1
		 		reset
		 	end
		  if pattern- @o_array == []
		 		puts "O wins!" 
		 		@score["O"] += 1
		 		reset
		  end
		end
		if @turn == 9 
			puts "Cat's game"  
			reset
		end
	end

	def reset #clear board
		puts "The score is Player X- #{@score["X"]}, Player O- #{@score["O"]}"
		@round += 1
		play_again
	end
	
	def play_again
		puts "That was awesome! You want to keep playing right? Enter y/n"
		keep_playing = gets.chomp
		while keep_playing != "y" && keep_playing != "n"
			puts "Um.. y/n?"
			keep_playing = gets.chomp
		end

		if keep_playing == "y"
			puts "Sweet, I bet this next round will be even more fun!" 
		  start 
		else
			puts "Alright. Well, good luck finding something better to do. "  
		  exit
		end
	end

end

TicTacToe.new

