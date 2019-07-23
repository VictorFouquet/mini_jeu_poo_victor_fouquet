require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'
		 
puts "	 	 ------------------------------------------------"
puts "		|    Bienvenue sur 'Ils veulent tous ma POO' !   |"
puts "		| Le but du jeu est d'être le dernier survivant! |"
puts " 		 ------------------------------------------------"
puts "", "	Quel est le nom de ton personnage? "
print "> " 
user = HumanPlayer.new(gets.chomp)

enemies = [player1 = Player.new("Tony le Forain"), player2 = Player.new("Boris le Rouge")]

while user.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0)
	sleep(2)
	puts "", "		++++++++++++++++++++++++++++++++++++++++++++++++++"
	puts "", user.show_state, ""
	puts "	Quelle action veux-tu effectuer ?", "", "		a - chercher une meilleure arme", "		s - chercher à se soigner", ""
	puts "	Attaquer un joueur en vue :", "		0 - #{player1.show_state}", "		1 - #{player2.show_state}", ""
	print "> " 
	choice = gets.chomp
	while !["a", "s", "0", "1"].include? choice
		puts "	Merci d'entrer un choix conforme aux propositions si tu veux que ça marche ;)"
		print "> "
		choice = gets.chomp
	end
	if choice == "a"
		user.search_weapon
	elsif choice == "s"
		user.search_health_pack
	elsif choice == "0"
		user.attacks(player1)
	else
		user.attacks(player2)
	end
	enemies.each do |enemy|
		if enemy.life_points > 0
			enemy.attacks(user)
		end
	end
end

puts "", "		++++++++++++++++++++++++++++++++++++++++++++++++++"
puts "", "	La partie est finie.", ""
if user.life_points > 0
	puts "		       B R A V O !  T U  A S  G A G N E !! "
else
	puts "	Loser ! Tu as perdu !"
end