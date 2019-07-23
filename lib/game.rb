class Game
	attr_accessor :human_player, :enemies, :players_left, :enemies_in_sight

	def initialize(name)
		@enemies = [player1 = Player.new("Boris le Soviet"), 
			player2 = Player.new("Diego le Gitan"), 
			player3 = Player.new("Salvatore le Parrain"), 
			player4 = Player.new("Shimizu le Yakuz"), 
			player5 = Player.new("DoggyPac le Thug"), 
			player6 = Player.new("Carillo de Medelin"), 
			player7 = Player.new("Dédé le Postiché"), 
			player8 = Player.new("Alkan l'Albanais"), 
			player9 = Player.new("Tak Khunn le Triade"), 
			player10 = Player.new("Un pov' mec qui passait par là")]
		@enemies_in_sight = []
		@human_player = HumanPlayer.new(name)
		@players_left = 10
	end

	def new_player_in_sight
		puts ""
		if @enemies.length == 0
			puts "	Tous les joueurs sont déjà en vue."
		end
		dice = rand(1..6)
		if dice == 1
			puts "	Aucun nouveau joueur n'ose rentrer dans le cercle..." 
		elsif dice <= 4 && dice >= 2
			enemy_selector = rand(0..(@enemies.length - 1))
			@enemies_in_sight.append(@enemies[enemy_selector])
			@enemies.delete_at(enemy_selector)
			puts "	#{@enemies_in_sight[-1].name} rentre dans le cercle..." "," 
		else
			2.times do
				enemy_selector = rand(0..(@enemies.length - 1))
				@enemies_in_sight.append(@enemies[enemy_selector])
				@enemies.delete_at(enemy_selector)
				sleep(1)
				puts "	#{@enemies_in_sight[-1].name} rentre dans le cercle..."
			end
		end
	end

	def kill_player(player)
		if player.life_points == 0
			@enemies_in_sight.delete_at(@enemies_in_sight.index(player).to_i)
			@players_left -= 1
		end
	end

	def is_still_ongoing?
		return @human_player.life_points > 0 && (@enemies_in_sight.length > 0 && @players_left > 0)
	end

	def menu
		puts "", "		++++++++++++++++++++++++++++++++++++++++++++++++++"
		puts "", human_player.show_state, ""
		puts "	Quelle action veux-tu effectuer ?", "", "		a - chercher une meilleure arme", "		s - chercher à se soigner", ""
		n = 0
		@enemies_in_sight.length.times do 
			puts "	Attaquer un joueur en vue :", "", "		#{n} - #{@enemies_in_sight[n].show_state}"
			n +=1
		end
		print "> " 
	end

	def menu_choice
		choice = gets.chomp
		puts "", "		++++++++++++++++++++++++++++++++++++++++++++++++++", ""
		if ((0..(enemies_in_sight.length-1)).include? choice && choice.to_i > (@enemies_in_sight.length - 1)) || (!["a", "s"].include? choice)
			puts "	Merci d'entrer une réponse conforme aux propositions pour que ça marche ;)"
			print "> "
			menu_choice
		end
		if choice == "a"
			human_player.search_weapon
		elsif choice == "s"
			human_player.search_health_pack
		else
			human_player.attacks(@enemies_in_sight[choice.to_i])
		end
		enemies_in_sight.each do |player|
			kill_player(player)
		end
	end

	def enemy_attacks
		if @enemies_in_sight.length > 0
			@enemies_in_sight.each do |enemy|
				enemy.attacks(human_player)
			end
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

binding.pry