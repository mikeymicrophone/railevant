require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe Railevance do
  describe 'caching ids' do
    
    before do
      @rails = Concept.create(:content => 'rails')
      @ruby = Concept.create(:content => 'ruby')
      @rails_ruby = Railevance.create(:rail_id => @rails.id, :tie_id => @ruby.id)
      @dhh = Concept.create(:content => 'DHH')
      @dhh_eureka = Railevance.create(:rail_id => @dhh.id, :tie_r_id => @rails_ruby.id)
    end
    
    it 'should call cache_in_components when created' do
      railevance = Railevance.new(:rail_id => @rails.id, :tie_r_id => @dhh_eureka.id)
      flexmock railevance
      railevance.should_receive(:cache_in_components).once
      railevance.save
    end
    
    it 'should call cache_connections on the right object with the right id hash' do
      railevance = Railevance.new :rail_id => @rails.id, :tie_r_id => @dhh_eureka.id
      flexmock @rails
      @rails.should_receive(:cache_connections).with({:tie_r => @dhh_eureka.id}).once
      railevance.save
    end
    
    it 'should call extant_connections when cache_in_components is called' do
      railevance = flexmock(Railevance.new(:rail_id => @rails.id, :tie_r_id => @dhh_eureka.id))
      railevance.should_receive(:extant_connections).and_return({:rail => @rails.id, :tie_r => @dhh_eureka.id}).at_least.once
      railevance.cache_in_components
    end
    
    it 'should populate the cache attribute when cache_connection is called' do
      @rails_ruby.cache_connection :rail_rs_ids, 25
      @rails_ruby.rail_rs_ids.should == [25]
    end
    
    it 'should create a railevance' do
      Railevance.count.should == 2
    end
    
    it 'should cache ids in connected concepts' do
      @rails.cached_ties.should == [@ruby]
    end
    
    it 'should cache ids in connected railevances' do
      @dhh.cached_railevance_ids.should == [@rails_ruby.id]
    end
    
    it 'should know that it has two extant connections' do
      @rails_ruby.extant_connections.keys.length.should == 2
    end
    
    it 'should have the correct keys in extant connections' do
      @rails_ruby.extant_connections.keys.include?(:rail).should == true
      @rails_ruby.extant_connections.keys.include?(:tie).should == true
      @dhh_eureka.extant_connections.keys.include?(:rail).should == true
      @dhh_eureka.extant_connections.keys.include?(:tie_r).should == true
    end
  end
end