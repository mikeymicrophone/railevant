require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe Concept do
  it 'should store characteristics' do
    valid_concept.characterize :updatable => 'yes'
    valid_concept.characteristic(:updatable).should == 'yes'
  end
  
  it 'should update characteristics' do
    valid_concept.characterize :updatable => 'yes for now'
    valid_concept.characterize :updatable => 'yes still'
    valid_concept.characteristic(:updatable).should == 'yes still'
  end
  
  it 'should list characteristics' do
    valid_concept.characterize :updatable => 'oh yeah'
    valid_concept.characterize :persistent => 'you know it'
    valid_concept.character.should have_key(:updatable)
    valid_concept.character.should have_key(:persistent)
  end
end