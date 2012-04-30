require 'config_loader/base'

module ConfigLoader
  class Yaml < Base
		def content
			@content ||= ::YAML::load file_content
		end
	end
end