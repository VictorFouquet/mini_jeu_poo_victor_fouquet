require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

player1 = Player.new("Diego le Gitan")
player2 = Player.new("Boris le Soviet")

puts "	Mesdames, Mesdemoiselles, Messieurs, bienvenue au combat du siècle !", ""
puts "	Dans l'arène à gauche, le célèbre, le redoutable, l'infâme, Tony le Forrraaaiiinnn !!"
puts "	A droite l'outsider du jour, l'irresponsable, le brutal, le fauve sibérien, Boris le Rooouuuuge !!", ""
puts player1.show_state
puts player2.show_state
puts "", "	Combattants, soyez sans pitié!", ""

while player1.life_points > 0 && player2.life_points > 0
	player2.attacks(player1)
	if player1.life_points == 0
		puts player2.show_state
		break
	end
	puts player1.show_state,""
	player1.attacks(player2)
	if player2.life_points == 0
		puts player1.show_state
		break
	end
	puts player2.show_state,""
end
