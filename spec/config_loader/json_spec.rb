# encoding: utf-8

require 'spec_helper'

describe ConfigLoader::Json do
  subject { config }
  let(:config) { ConfigLoader::Json.new '/data/addresses.json', :locale => 'da' }

  its(:file_name) { should == 'addresses.da.json' }
  its(:root)      { should be_nil }
  its(:ext)       { should == 'json' }

  its(:content) { should_not be_nil }
  its(:content) { should == [{"number"=>"004", "street"=>"Bøllemosegårdsvej", "city"=>"Øbro", "region"=>"København"}, {"number"=>"001", "street"=>"Bøllemosegårdsvej", "city"=>"Venners", "region"=>"København"}, {"number"=>"002", "street"=>"Havlyngbuen", "city"=>"Amager", "region"=>"København"}, {"number"=>"001", "street"=>"Havlyngbuen", "city"=>"Amager", "region"=>"København"}, {"number"=>"051", "street"=>"Hedegaardsvej", "city"=>"Engdraget", "region"=>"København"}] }
end

describe '.load' do
  subject { addresses }
  let(:addresses) { MainApp.config.addresses }

  specify do
    addresses.first.should == {"number"=>"004", "street"=>"Bøllemosegårdsvej", "city"=>"Øbro", "region"=>"København"}
  end
end
