module WithCallback

	module ClassMethods

		attr_accessor	:before_callbacks, :after_callbacks

		def before(kind, callback)
			self.before_callbacks = self.before_callbacks.merge kind => before_callbacks[kind] + [callback]
        end

        def after(kind, callback)
  			self.after_callbacks = self._after_callbacks.merge kind => after_callbacks[kind] + [callback]
        end

        def init_hash
        	self.after_callbacks = Hash.new []
        	self.before_callbacks = Hash.new []
        end

	end

	module InstanceMethods

        def with_callbacks(kind)
	        self.class.before_callbacks[kind].each { |c| send c } if !self.class.before_callbacks[kind].empty?
	        yield
	        self.class.after_callbacks[kind].each { |c| send c } if !self.class.after_callbacks[kind].empty?
	    end

	end

	def self.included(receiver)
		receiver.extend         ClassMethods
		receiver.send :include, InstanceMethods
		receiver.init_hash
	end

end

class User

	include  WithCallback

	before :talk, :pwet

	def talk
		with_callbacks(:talk) do
			puts 'talk'
		end
	end

	def titi
		puts "titi"
	end

	def pwet
		puts 'pwet'
	end

end

u = User.new
puts u.talk