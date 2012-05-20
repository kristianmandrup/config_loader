require 'hashie'

module ConfigLoader
	class Base
  	attr_reader :locale, :path, :file_name, :ext, :file_path, :root

  	# will try root element if such exists
		def initialize file_path, options = {}
			@path 		 	= File.dirname file_path
			@file_name 	= File.basename file_path			
			name 				= parts.first.sub(/\.$/, '')
			@ext 			 	= parts.last
			@locale 		= options[:locale] unless blank?(options[:locale])

			unless blank? @locale
				@file_name = [name, @locale, @ext].compact.join('.')
				@file_path =  File.join(@path, @file_name)
			end

			@dir 				= '' if file_path[0] == '/'
			@dir 				= options[:dir] if options[:dir]
			@root 		 	= (options[:root] || file_name.split('.').first).to_s			
			@root 		 	= nil unless mashie.send(@root)
			@mashie 	 	= mashie.send(@root) if @root
		rescue NoMethodError # if no mashie
			@root = nil
		end

		def as_hash
			@as_hash ||= mashie
		end

		def load *args
		end

		protected

		def blank? obj
			!obj || obj.empty?
		end


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