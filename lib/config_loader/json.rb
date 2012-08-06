require 'config_loader/base'

module ConfigLoader
  class Json < Base
    def initialize file_path, options = {}
      file_path = "#{file_path}.json" unless path?(file_path)
      super file_path, options
    end

		def content
			@content ||= JSON.parse file_content.read
		end

    def reg_ext_format
      'json'
    end    
	end
end