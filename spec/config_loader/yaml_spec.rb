require 'spec_helper'

describe ConfigLoader::Yaml do
	subject { config }
	let(:config) { ConfigLoader::Yaml.new('facebook.yml') }

	its(:file_name) { should == 'facebook.yml' }
	its(:root) 			{ should == 'facebook' }
	its(:ext) 			{ should == 'yml' }

	its(:content) { should_not be_nil }
	its(:as_hash) { should be_a Hash }

	specify { subject.as_hash.domain == 'www.facebook.com' }

	describe 'implicit yml' do
		subject { config }
		let(:config) { ConfigLoader::Yaml.new(:htc) }

		its(:root) 	 { should == nil }
		specify { subject.as_hash.domain == 'www.htc.com' }
	end

	describe 'no root' do
		subject { config }
		let(:config) { ConfigLoader::Yaml.new('htc.yml') }

		its(:root) 	 { should == nil }
		specify { subject.as_hash.domain == 'www.htc.com' }
	end

	describe 'specific root' do
		subject { config }
		let(:config) { ConfigLoader::Yaml.new('htc.yml', :root => 'root') }

		its(:root) 	 { should == 'root' }
		specify { subject.as_hash.domain == 'www.htc.dk' }
	end
end

describe '.load_hash' do
	subject { property }
	let(:property) { MainApp.config.property }

  specify { subject.type.house_boat.should == 'house boat' }
end

describe '.load' do
	subject { app }
	let(:app) { MainApp.config.app }

	specify { subject.as_hash.name.should == 'HTC' }
end