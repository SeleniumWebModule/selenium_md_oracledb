require 'spec_helper'
describe 'selenium_md_oracledb' do
  context 'with default values for all parameters' do
    it { should contain_class('selenium_md_oracledb') }
  end
end
