class TicTacToe
	
	WINNING_PATTERNS = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]] 
		
	def initialize 
		@score = {"X" => 0, "O" => 0}
		@round = 1
		puts "Play by entering the number\nthat corresponds with the space you choose"
	end

	def start
		@turn = 1
		@x_array = []
		@o_array = []
		@available_spaces = [*1..9]
		@board = "   1 2 3\n   4 5 6\n   7 8 9"
		@winner = false
	end

	def new_round
		new_round = false
	end

		
	def x_or_o #validate choice of team either x or o
		team_choice = nil
		puts "You are the first player, do you want to be X's or O's ?" if team_choice.nil?
		team_choice = gets.chomp.upcase
		if team_choice == 'X' || team_choice == 'O' 
		  puts "Cool, you're on team #{team_choice}" 
		  @player_x, @player_o = 'X','O'	 
		else 
		 	puts "Dude, just type an x or an o" 
			x_or_o
		end
	end

	def whose_turn # alternates which player starts each round
		if @round%2 == 1 
			@first_player, @second_player = "X", "O"
		else
			@first_player, @second_player = "O", "X"
		end	
	end

	def play_turn
		puts "Let's play round #{@round}" if @round > 1 && @turn == 0
		@turn%2 == 1 ? @player = @first_player : @player = @second_player
		puts "Player #{@player} goes first this round" unless @turn > 1
		puts "Player #{@player} choose a space"
		puts @board
		@turn += 1
	end

	def val_choice #make sure only 1-9, or whatever is left is entered
		@choice = gets.chomp
		if @available_spaces.include?(@choice.to_i) 
			@board = @board.gsub(@choice, @player)
			puts @board
			@available_spaces.delete(@choice.to_i)
		else
			puts "Nope, enter an available space.  Try again" 
			val_choice
		end
	end

	def chosen_spaces #this chooses which array to push the chose space to depending on whose turn it is
		if @player == "X"
			@x_array << @choice.to_i
		else
			@o_array << @choice.to_i
		end
	end

	def round_won #check to see if any winning patterns, or if board is full then 'tie'
		WINNING_PATTERNS.each do |pattern|
			if pattern - @x_array == []
		 		puts "X wins!" 
		 		@score["X"] += 1
		 		@winner = true
		 		return
		 	end
		  if pattern - @o_array == []
		 		puts "O wins!" 
		 		@score["O"] += 1
		 		@winner = true
		 		return
		  end
		end
		if @turn == 9 
			puts "Cat's game"  
			@winner = true
		end
		p @turn
	end

	def update_score #clear board
		if @winner
			puts "The score is Player X- #{@score["X"]}, Player O- #{@score["O"]}" 
			@round += 1
		end
	end

	def round_is_over?
		@winner ? true : false
	end
	
	def play_again #after every round
		puts "That was awesome! You want to keep playing right? Enter y/n"
		keep_playing = gets.chomp
		while keep_playing != "y" && keep_playing != "n"
			puts "Um.. y/n?"
			keep_playing = gets.chomp
		end

		if keep_playing == "y"
			puts "Sweet, I bet this next round will be even more fun!" 
		  @game_over = false
		else
			puts "Alright. Well, good luck finding something better to do. "  
		  @game_over = true
		end
	end

	def is_over?
		@game_over
	end

	def good_bye
		puts "Thanks for playing"
		exit
	end

end

game = TicTacToe.new

game.x_or_o
while !game.is_over?
	round = game
	game.start
	while !game.round_is_over?
		game.whose_turn
		game.play_turn
		game.val_choice
		game.chosen_spaces
		game.round_won
		game.update_score
		game.round_is_over?
	end
	game.new_round
	game.play_again
end		
game.good_bye
