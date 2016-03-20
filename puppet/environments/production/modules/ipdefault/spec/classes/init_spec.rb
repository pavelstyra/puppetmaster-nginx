require 'spec_helper'
describe 'ipdefault' do

  context 'with defaults for all parameters' do
    it { should contain_class('ipdefault') }
  end
end
