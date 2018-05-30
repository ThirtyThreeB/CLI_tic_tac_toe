class Play
	
	@@score = {"X" => 0, "O" => 0}
	@@round = 1
	@winning_patterns = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
	attr_accessor :player_x, :player_o, :board, :current_player, :turn   
		
	def self.start
		@turn = 1
		@available_spaces = [*1..9]
		@x_array = []
		@o_array = []
		@board = "   1 2 3\n   4 5 6\n   7 8 9"

		if @@round == 1
			puts @board
			puts "Here is the gameboard,\nyou'll play by entering the number\nthat corresponds with the space you choose"
			self.choose_team
		else 
			puts "Let's play round #{@@round}"
			#puts @board
		end	
		self.whose_turn
	end

	def self.choose_team 
		puts "You are the first player, do you want to be X's or O's ?"
		self.x_or_o
	end
		
	def self.x_or_o #validate choice of team either x or o
		team_choice = gets.chomp.upcase
		if team_choice == 'X' || team_choice == 'O' 
		  puts "Cool, you're on team #{team_choice}" 
		  @player_x, @player_o = 'X','O'	 
		else 
		 	puts "Dude, just type an x or an o" 
			self.x_or_o
		end
	end

	def self.whose_turn 

		if @@round%2 == 1 # X's starting round when odd
			@first_player, @second_player = "X", "O"
		else
			@first_player, @second_player = "O", "X"
		end

		@turn%2 == 1 ? self.play_turn(@first_player) : self.play_turn(@second_player) #switches between player x and player o
	end

	def self.play_turn(player) 
		puts "Player #{player} goes first this round" unless @turn > 2
		puts "Player #{player} choose a space"
		puts @board
		self.val_choice(player)
		@turn += 1
		self.end_game #should this be called self.end_game? even though it doesn't return a boolean?
		self.whose_turn
	end

	def self.val_choice(player) #make sure only 1-9, or whatever is left is entered
		choice = gets.chomp
		if @available_spaces.include?(choice.to_i) 
			@board = @board.gsub(choice, player)
			puts @board
			self.chosen_spaces(choice, player)
			@available_spaces.delete(choice.to_i)
		else
			puts "Nope, enter an available space.  Try again" 
			self.val_choice(player)
		end
	end

	def self.chosen_spaces(choice, player) #this chooses which array to push the chose space to depending on whose turn it is
		if player == "X"
			@x_array << choice.to_i
			else
			@o_array << choice.to_i
		end
	end

	def self.end_game #check to see if any winning patterns, or if board is full then 'tie'
		@winning_patterns.each do |pattern|
			if pattern- @x_array == []
		 		puts "X wins!" 
		 		@@score["X"] += 1
		 		self.reset
		 	end
		  if pattern- @o_array == []
		 		puts "O wins!" 
		 		@@score["O"] += 1
		 		self.reset
		  end
		end
		if @turn == 9 
			puts "Cat's game"  
			self.reset
		end
	end

	def self.reset #clear board
		puts "The score is Player X- #{@@score["X"]}, Player O- #{@@score["O"]}"
		@@round += 1
		self.start
	end
	
end

Play.new
Play.start
