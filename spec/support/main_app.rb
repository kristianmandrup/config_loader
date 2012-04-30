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

		# config for the app
		# any missing method on this is delegated to the Hashie wrapping this # loaded content
		def config
			@config ||= load_yaml('app.yml')
		end

		# auto detect load method based on filename
		def app
			@app ||= load('app.yml')
		end

		def payment_provider
			@payment_provider ||= load_yaml('payment_gateway/quickpay.yml')
		end
	end
end