require 'json/pure'
require 'singleton'

module MainApp
	def self.config
		Config.instance
	end

	class Config
		include Singleton
		include ConfigLoader::Delegator

		# load seed file (see geo-autocomplete demo)
		def seed
			@seed ||= load_yaml('config/seed.yml', :dir => 'db')
		end

		def payment_provider
			@payment_provider ||= load_yaml('payment_gateway/quickpay.yml')
		end
	end
end