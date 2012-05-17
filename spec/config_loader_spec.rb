require 'spec_helper'

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