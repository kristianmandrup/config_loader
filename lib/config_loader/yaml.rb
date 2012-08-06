require 'config_loader/base'

module ConfigLoader
  class Yaml < Base
    def initialize file_path, options = {}
      default_ext = options[:default_ext] || 'yml'
      file_path = "#{file_path}.#{default_ext}" unless path?(file_path)
      super file_path, options
    end

		def content
			@content ||= ::YAML.load file_content
		end

    protected

    def reg_ext_format
      'ya?ml'
    end
	end
end