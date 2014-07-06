require './callback'

class Toto

	include Callback

	before :titi, :plop

	def titi
		puts "titi"
	end

	private

	def plop
		puts "plop"
	end


end


t = Toto.new

t.titi