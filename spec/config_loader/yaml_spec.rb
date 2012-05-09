require 'spec_helper'

module Rails
	def self.root
		File.join SPEC_DIR, 'fixtures'
	end
end

class LoadMe
	include ConfigLoader	
end

describe ConfigLoader::Yaml do
	subject { config }
	let(:config) { ConfigLoader::Yaml.new('facebook.yml') }

	its(:file_name) { should == 'facebook.yml' }
	its(:root) 			{ should == 'facebook' }
	its(:ext) 			{ should == 'yml' }

	its(:content) { should_not be_nil }
	its(:as_hash) { should be_a Hash }

	specify { subject.as_hash.domain == 'www.facebook.com' }

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

describe ConfigLoader do
	subject { loadme }

	let(:loadme) { LoadMe.new }

	describe '.load' do
		specify { subject.load('htc.yml').as_hash.domain.should == 'www.htc.com' }
	end

	describe '.load_hash' do
		specify { subject.load_hash('htc.yml').domain.should == 'www.htc.com' }
	end
end

describe 'Delegator' do
	subject { config }
	let(:config) { MainApp.config }

	specify { subject.as_hash.name.should == 'HTC' }
end

describe '.load' do
	subject { app }
	let(:app) { MainApp.config.app }

	specify { subject.as_hash.name.should == 'HTC' }
end