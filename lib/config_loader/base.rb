require 'hashie'

module ConfigLoader
	class Base
  	attr_reader :locale, :path, :file_name, :ext, :file_path, :root

  	# will try root element if such exists
		def initialize file_path, options = {}			
			@path 		 	= File.dirname file_path
			@file_name 	= File.basename file_path			
			parts 			= file_name.split(/(ya?ml$)/)
			name 				= parts.first
			@ext 			 	= parts.last
			@locale 		= options[:locale]

			@file_path 	= @locale ? File.join(@path, "#{@name}.#{@locale}.#{@ext}") : file_path

			@dir 				= options[:dir] if options[:dir]
			@root 		 	= (options[:root] || file_name.split('.').first).to_s			
			@root 		 	= nil unless mashie.send(@root)
			@mashie 	 	= mashie.send(@root) if @root
		end

		def as_hash
			@as_hash ||= mashie
		end

		protected

		def file_content
			File.open(config_file_path)
		end

		def dir
			@dir ||= 'config'
		end

		def mashie
			@mashie ||= ::Hashie::Mash.new content
		end

    def config_file_path
    	@config_file_path ||= File.join(Rails.root.to_s, dir, file_path)
    end
	end
end