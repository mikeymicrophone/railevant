require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe String do
  before do
    @code = '11,22,33,44,55,66,77,88,99,20'
  end
  
  it 'should do something' do
    puts @code.wrap_for_code 22
  end
end