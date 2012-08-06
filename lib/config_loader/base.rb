require 'hashie'

module ConfigLoader
  def self.config &block
    block_given? ? yield(Config) : Config
  end 

  module Config
    class << self
      attr_accessor :locale_spacer, :locale

      def locale_on!
        @locale = true
      end

      def locale_off!
        @locale = false
      end
    end
  end

	class Base
  	attr_reader :name, :locale, :path, :file_name, :ext, :file_path, :root, :options

  	# will try root element if such exists
		def initialize file_path, options = {}
      @options    = options		
			@path 		 	= File.dirname file_path
			@file_name 	= File.basename file_path			

			@name 				= parts.first.sub(/\.$/, '')
			@ext 			 	= parts.last
			@locale 		= extract_locale
			@file_path = file_path

			if @locale
				@file_name = locale_filename
				@file_path =  File.join(@path, @file_name)
			end

			@dir 				= '' if file_path[0] == '/'
			@dir 				= options[:dir] if options[:dir]
			@root 		 	= get_root
			@root 		 	= nil unless mashie.send(@root)
			@mashie 	 	= mashie.send(@root) if @root

      if @locale
        @locale_root    = @locale
        @locale_root    = nil unless mashie.send(@locale_root)
        @mashie         = mashie.send(@locale_root) if @locale_root
      end
		rescue NoMethodError # if no mashie
			@root = nil
      @locale_root = nil
		end

		def as_hash
			@as_hash ||= mashie
		end

		def load *args
		end

		protected

    def get_root
      (options[:root] || file_name.split('.').first).to_s
    end

    def locale_filename
      [[name, @locale].compact.join(locale_spacer), @ext].compact.join('.')
    end

    def locale_spacer
      ConfigLoader.config.locale_spacer || options[:locale_spacer] || '_'
    end

    def parts
      @parts ||= file_name.split(/(#{reg_ext_format})$/)
    end

    def path? file_path
      file_path.kind_of?(String) && file_path =~ /\.#{reg_ext_format}/
    end

    def extract_locale
      loc = options[:locale]
      loc = ConfigLoader.config.locale if loc.nil?
      return I18n.locale if loc == true
      return nil if loc == false
      loc
    end

		def blank? obj
			obj.nil? || obj.empty?
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