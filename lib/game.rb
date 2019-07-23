class Game
	attr_accessor :human_player, :enemies

	def initialize(name)
		@enemies = [player1 = Player.new("Boris le Rouge"),
		player2 = Player.new("Tony le Forain"),
		player3 = Player.new("Salvatore il Padrino"),
		player4 = Player.new("Shimizu le Bakuto")]
		@human_player = HumanPlayer.new(name)
	end

	def kill_player(player)
		if player.life_points == 0
			@enemies.delete_at(@enemies.index(player))
		end
	end

	def is_still_ongoing?
		return @human_player.life_points > 0 && @enemies.length > 0
	end

	def menu
		puts "", "		++++++++++++++++++++++++++++++++++++++++++++++++++"
		puts "", human_player.show_state, ""
		puts "	Quelle action veux-tu effectuer ?", "", "		a - chercher une meilleure arme", "		s - chercher à se soigner", ""
		if @enemies.length == 4
			puts "	Attaquer un joueur en vue :", "		0 - #{@enemies[0].show_state}", "		1 - #{@enemies[1].show_state}", "		2 - #{@enemies[2].show_state}", "		3 - #{@enemies[3].show_state}", ""
		elsif @enemies.length == 3
			puts "	Attaquer un joueur en vue :", "		0 - #{@enemies[0].show_state}", "		1 - #{@enemies[1].show_state}", "		2 - #{@enemies[2].show_state}" , ""
		elsif @enemies.length == 2
			puts "	Attaquer un joueur en vue :", "		0 - #{@enemies[0].show_state}", "		1 - #{@enemies[1].show_state}", ""
		else
			puts "	Attaquer un joueur en vue :", "		0 - #{@enemies[0].show_state}", ""
		end
		print "> " 
	end

	def menu_choice
		choice = gets.chomp
		puts "", "		++++++++++++++++++++++++++++++++++++++++++++++++++", ""
		if (["0", "1", "2", "3"].include? choice && choice.to_i > (@enemies.length - 1)) || (!["0", "1", "2", "3", "a", "s"].include? choice)
			puts "	Merci d'entrer une réponse conforme aux propositions pour que ça marche ;)"
			print "> "
			menu_choice
		end
		if choice == "a"
			human_player.search_weapon
		elsif choice == "s"
			human_player.search_health_pack
		elsif choice == "0"
			human_player.attacks(@enemies[0])
		elsif choice == "1"
			human_player.attacks(@enemies[1])
		elsif choice == "2"
			human_player.attacks(@enemies[2])
		elsif choice == "3"
			human_player.attacks(@enemies[3])
		end
		enemies.each do |player|
			kill_player(player)
		end
	end

	def enemy_attacks
		@enemies.each do |enemy|
			enemy.attacks(human_player)
		end
	end

	def end_game
		puts "", "		++++++++++++++++++++++++++++++++++++++++++++++++++"
		puts "", "	La partie est finie.", ""
		if human_player.life_points > 0
			puts "		       B R A V O !  T U  A S  G A G N E !! "
		else
			puts "	Loser ! Tu as perdu !"
		end
	end

end

