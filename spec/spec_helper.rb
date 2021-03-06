# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'spec'
require 'spec/rails'

Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'

  # == Fixtures
  #
  # You can declare fixtures for each example_group like this:
  #   describe "...." do
  #     fixtures :table_a, :table_b
  #
  # Alternatively, if you prefer to declare them only once, you can
  # do so right here. Just uncomment the next line and replace the fixture
  # names with your fixtures.
  #
  # config.global_fixtures = :table_a, :table_b
  #
  # If you declare global fixtures, be aware that they will be declared
  # for all of your examples, even those that don't use them.
  #
  # You can also declare which fixtures to use (for example fixtures for test/fixtures):
  #
  # config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  #
  # == Mock Framework
  #
  # RSpec uses it's own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  config.mock_with :flexmock
  # config.mock_with :rr
  #
  # == Notes
  # 
  # For more information take a look at Spec::Example::Configuration and Spec::Runner
end

def valid_new_concept(opts = {})
  type = opts[:type] || 'Library'
  @c = Concept.create(valid_concept_params(opts))
  @c.update_attribute(:type, type)
  @c
end

def valid_concept(opts = {})
  Concept.first || Concept.find(valid_new_concept(opts).id)
end

def valid_concept_params(opts = {})
  {:content => 'memcached', :railser_id => valid_railser.id}.reverse_merge(opts)
end

def second_valid_concept(opts = {})
  Concept.find_by_type('Release') || Concept.create(second_valid_concept_params(opts))
end

def second_valid_concept_params(opts = {})
  {:type => 'Release', :content => '1.0', :railser_id => valid_railser.id}.reverse_merge(opts)
end

def valid_railser(opts = {})
  Railser.first || Railser.create(valid_railser_params(opts))
end

def valid_railser_params(opts = {})
  {:login => 'schwabsauce', :email => 'mike.schwab@gmail.com'}.reverse_merge(opts)
end

def valid_railevance(opts = {})
  Railevance.first || Railevance.create(valid_railevance_params(opts))
end

def valid_railevance_params(opts = {})
  {:rail_id => valid_concept.id, :tie_id => second_valid_concept.id, :railser_id => valid_railser.id}.reverse_merge(opts)
end

def valid_vote(opts = {})
  Vote.first || Vote.create(valid_vote_params(opts))
end

def valid_vote_params(opts = {})
  {:rating => 10, :concept_id => valid_concept.id, :railser_id => valid_railser.id}.reverse_merge(opts)
end