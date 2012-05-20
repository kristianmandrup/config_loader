require 'config_loader/base'

module ConfigLoader
  class Json < Base
		def content
			@content ||= JSON.parse file_content.read
		end

    def parts
      @parts ||= file_name.split(/(json)$/)
    end    
	end
end