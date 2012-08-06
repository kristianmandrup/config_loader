# Config loader

Nice little utility to load config files from the Rails config dir or even in other locations. Supports YAML and JSON formats that are wrapped in a Hashie for nice method and hash access.

```ruby
module MainApp
	def self.config
		Config.instance
	end

	class Config
		include Singleton
		include ConfigLoader::Delegator

		# load seed file (see geo-autocomplete demo)
		def seed
			@seed ||= load_yml :seed, :dir => 'db')
		end

		# config for the app
		# any missing method on this is delegated to the 
		# Hashie wrapping this loaded content
		def config
			@config ||= load_yml :app
		end

		# auto detect load method based on filename extension
		def app
			@app ||= load 'app.yml'
		end

		# load json content
		def addresses locale = :da
			@config ||= load_content '/data/addresses.json', :locale => get_locale(locale)
		end

		def payment_provider
			@payment_provider ||= load_yaml 'payment_gateway/quickpay'
		end
	end
end
```

## Contributing to config_loader
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 Kristian Mandrup. See LICENSE.txt for
further details.

