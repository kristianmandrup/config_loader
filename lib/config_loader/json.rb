require 'config_loader/base'

module ConfigLoader
  class Json < Base
		def content
			@content ||= JSON.parse file_content.read
		end
	end
end