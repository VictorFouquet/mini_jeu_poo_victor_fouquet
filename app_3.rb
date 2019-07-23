require 'bundler'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/game'

3.times do 
	puts ""
end
puts "	 	 ------------------------------------------------"
puts "		|    Bienvenue sur 'Ils veulent tous ma POO' !   |"
puts "		| Le but du jeu est d'être le dernier survivant! |"
puts " 		 ------------------------------------------------"
puts "", "	Quel est le nom de ton personnage? "
print "> " 

my_game = Game.new(gets.chomp)

while my_game.is_still_ongoing?
	sleep(2)
	my_game.menu
	my_game.menu_choice
	my_game.enemy_attacks
end

my_game.end_game

#binding.pry

