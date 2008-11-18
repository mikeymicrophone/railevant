require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe Railser do
  before do
    @ten_guys = []
    10.times do |railser|
      @ten_guys << valid_railser(:login => railser.to_s, :email => "#{railser}@gmail.com")
    end
    @person = valid_concept(:content => 'Mike Schwab', :type => 'Person')
  end
  
  it 'should look for ten random users when an identity is claimed' do
    flexmock Railser
    Railser.should_receive(:random).once.with(10).and_return(@ten_guys)
    valid_railser.claim(@person.id)
  end
  
  it 'should create a string when an identity is claimed' do
    user = valid_railser(:login => 'schwabsauce', :email => 'mike.schwab@gmail.com')
    user.claim @person.id
    user.activation_code.should be
  end
  
  it 'should adjust the code when verified by a first user'
  
  it 'should remove the code when verified by a second user'
end