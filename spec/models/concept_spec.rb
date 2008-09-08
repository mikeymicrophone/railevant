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

  it 'should initialize character to empty hash' do
    valid_concept.character.should == {}
  end

  it 'should notice ambiguity when another concept has same name' do
    c1 = valid_concept
    c2 = Concept.create valid_concept_params(:type => 'Tool')
    c2.should be_valid
    c1.effective_uri.should == c2.effective_uri
    Concept.disambiguate
    c1.should be_ambiguous
  end
  
  it 'should be able to disambiguate concepts' do
    c1 = valid_concept
    c2 = Concept.create valid_concept_params(:type => 'Tool')
    c1.disambiguate_with c2
    c1.should be_ambiguous
  end

  it 'should be able to list unambiguous concepts' do
    c = valid_concept
    Concept.unambiguous.first.should == c
  end
  
  it 'should consider a new concept unambiguous' do
    valid_concept.should_not be_ambiguous
  end
  
  it 'should leave unambiguous concepts out of the ambiguous array' do
    valid_concept
    Concept.ambiguous.should be_blank
  end

  it 'should leave unambiguous concepts in unambiguous array' do
    valid_concept
    Concept.unambiguous.should_not be_blank
    Concept.unambiguous.first.should == valid_concept
  end

end