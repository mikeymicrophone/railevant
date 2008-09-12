require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe Railevance do
  describe 'caching ids' do
    it 'should cache ids in connected concepts' do
      r = Concept.create(:content => 'rails')
      t = Concept.create(:content => 'ruby')
      r.is_railevant_to t
      r.cached_ties.should == [t]
    end
  end
end