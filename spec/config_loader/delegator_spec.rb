require 'spec_helper'

describe 'Delegator' do
  subject { config }
  let(:config) { MainApp.config }

  specify { subject.as_hash.name.should == 'HTC' }
end
