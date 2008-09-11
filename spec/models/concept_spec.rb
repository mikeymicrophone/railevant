require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe Concept do
  before do
    Concept.destroy_all
  end
  
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
    
  it 'should find ambiguities using find_by_effective_uri' do
    flexmock Concept
    Concept.should_receive(:find_by_effective_uri)
    Concept.new.disambiguate
  end
  
  it 'should receive disambiguate_with regardless of whether another concept shares that effective uri' do
    @concept = flexmock(valid_concept)
    @concept.should_receive(:disambiguate)
    @concept.should_receive(:disambiguate_with)
    @concept.disambiguate
  end
  
  it 'should call disambiguate_with with the right concepts' do
    c1 = valid_concept
    c2 = Concept.create valid_concept_params(:type => 'Tool')
    c1.disambiguate
    c2.should be_ambiguous
  end
  
  it 'should be graceful if disambiguate_with is called with nil argument' do
    valid_concept.disambiguate_with nil
  end
  
  it 'should mark ambiguous concepts as ambiguous when disambiguated' do
    c1 = flexmock valid_concept
    c2 = Concept.create valid_concept_params(:type => 'Tool')
    c1.disambiguate_with c2
    c1.should be_ambiguous
  end
  
  it 'should be able to disambiguate concepts' do
    c1 = valid_concept
    c2 = Concept.create valid_concept_params(:type => 'Tool')
    c1.disambiguate_with c2
    c1.should be_ambiguous
    c2.should be_ambiguous
  end
  
  it 'should save id in ambiguous array when disambiguated' do
    c1 = valid_concept
    c2 = Concept.create valid_concept_params(:type => 'Tool')
    c1.is_ambiguous_with c2
    c1.ambiguous.should == [c2.id]
  end

  it 'should be able to list unambiguous concepts' do
    c = valid_concept
    Concept.unambiguous.first.should == c
  end
  
  it 'should consider a new concept unambiguous' do
    Concept.create(:content => 'ambition').should_not be_ambiguous
  end
  
  it 'should leave unambiguous concepts out of the ambiguous array' do
    valid_concept
    Concept.ambiguous.should be_blank
  end

  it 'should leave unambiguous concepts in unambiguous array' do
    puts Concept.all.length
    valid_concept
    puts Concept.all.length
    puts valid_concept.id
    puts valid_concept.ambiguous.class.name
    valid_concept.should_not be_ambiguous
    Concept.unambiguous.should_not be_blank
    Concept.unambiguous.first.should == valid_concept
  end

end