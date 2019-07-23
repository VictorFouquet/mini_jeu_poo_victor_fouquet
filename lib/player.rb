class Player

	attr_accessor :name, :life_points

	def initialize(name)
		@name = name
		@life_points = 10
	end

	def show_state
		return "	#{@name} a #{@life_points} points de vie"
	end

	def gets_damage(damage)
		@life_points -= damage
		if @life_points <= 0 
			@life_points = 0 
			puts "	Le joueur #{@name} a été tué !"	
		end
	end

	def attacks(player)
		sleep(2)
		puts "", "	Le joueur #{@name} attaque le joueur #{player.name}" 
		damage = compute_damage
		puts "	Il lui inflige #{damage} points de dommages."
		player.gets_damage(damage)	
	end

	def compute_damage
		return rand(1..6)
	end

end

class HumanPlayer < Player
	attr_accessor :weapon_level

	def initialize(name)
		super(name)
		@life_points = 100
		@weapon_level = 1
	end

	def show_state
		return super + " et une arme de niveau #{@weapon_level}"
	end

	def compute_damage
		return super * @weapon_level
	end

	def search_weapon
		dice = rand(1..6)
		if dice > @weapon_level
			@weapon_level = dice
			puts "", "	Redoutable, tu remplaces ton arme pour une nouvelle de niveau #{weapon_level}, attention les dégâts...", ""
		else
			puts "", "	Bredouille, que des armes khénées dans la zone...", ""
		end
	end

	def search_health_pack
		dice = rand(1..6)
		if dice == 1
			puts "	Reste en chien..."
		elsif (2..5).include? dice
			@life_points += 50
			if @life_points > 100
				@life_points = 100
			end
			puts "	Tu es refait, tu as trouvé un pack de +50 PV !" 
		else
			@life_points += 80
			if @life_points > 100
				life_points = 100
			end
			puts "	Tu es en bombe, tu as trouvé un pack de +80PV !!"
		end
	end

end 