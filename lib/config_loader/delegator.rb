module ConfigLoader
	module Delegator	
		def self.included(base)
			base.send :include, ConfigLoader
		end

	  def method_missing(m, *args, &block)
	  	raise "A #config method must be defined in the container for ConfigLoader::Delegator, for it to delegate to #config: delegation attempted with #{m}" unless self.respond_to?(:config)
	    config.send(m)
	  end
	end
end