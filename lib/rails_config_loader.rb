require 'config_loader/yaml'
require 'config_loader/json'
require 'config_loader/delegator'

module ConfigLoader
	def load file_path, options = {}
		ext 	 = File.basename(file_path).split(/(ya?ml|json)$/).last
		loader = case ext.to_sym
		when :json
			ConfigLoader::Json
		when :yml, :yaml
			ConfigLoader::Yaml
		end
		loader.new file_path, options
	end

	def load_content file_path, options = {}
		load(file_path, options).content
	end

	def load_hash file_path, options = {}
		load(file_path, options).as_hash
	end

	def load_yaml file_path, options = {}
		ConfigLoader::Yaml.new file_path, options = {:default_ext => :yaml}
	end

	def load_yml file_path, options = {}
		ConfigLoader::Yaml.new file_path, options = {:default_ext => :yml}
	end

	def load_json file_path, options = {}
		ConfigLoader::Json.new file_path, options = {}
	end

	def load_json_content file_path, options = {}
		load_json(file_path, options).content
	end	
end