class Concept < ActiveRecord::Base
  belongs_to :railser
  has_many :railevances, :foreign_key => 'tie_id'
  has_many :rails, :through => :railevances, :source => 'rail'
  has_many :railsconcepts, :foreign_key => 'rail_id', :class_name => 'Railevance'
  has_many :ties, :through => :railsconcepts, :source => 'tie'
  has_many :votes
  has_many :voters, :through => :votes, :source => :railser
  validates_presence_of :content
  before_create :cache_uri, :set_empty_character
  after_save :disambiguate
  serialize :character, Hash
  serialize :ambiguous, Array
  serialize :rails_ids, Array
  serialize :ties_ids, Array
  serialize :rail_rs_ids, Array
  serialize :tie_rs_ids, Array
  acts_as_paranoid
  
  def is_railevant_to t
    case t.class.name
    when 'Railevance'
      Railevance.create(:rail_id => id, :tie_r_id => t.id)
    when 'Concept'
      Railevance.create(:rail_id => id, :tie_id => t.id)
    when 'Integer'
      Railevance.create(:rail_id => id, :tie_id => t)
    end
  end
  
  def characterize characteristics = {}
    update_attribute :character, character.merge(characteristics)
  end
  
  def characteristic key
    character[key]
  end
  
  def characteristic_strength key
    votes.select { |v| v.characteristic_id == key }.average(:rating)
  end
  
  def railavence_strength which
    which = which.id if which.is_a? ActiveRecord::Base
    railevances.select { |r| r.rail_id == which || r.tie_id == which }.map(&:votes).flatten.average(:rating)
  end
    
  def average_vote
    votes.undesignated.average(:rating)
  end
  
  def average_of_all_votes
    votes.average(:rating)
  end
  
  def disambiguate
    ambiguous_concept = Concept.find_by_effective_uri(effective_uri)
    disambiguate_with ambiguous_concept
  end
  
  def self.ambiguous
    all.select &:ambiguous?
  end
  
  def self.unambiguous
    all - ambiguous
  end
  
  def disambiguate_with concept
    return if concept.nil?
    concept.ambiguities.push(concept).each do |c|
      self.is_ambiguous_with c
      c.is_ambiguous_with self
    end
  end
  
  def is_ambiguous_with concept
    return if concept.id == id
    self.ambiguous ||= []
    update_attribute :ambiguous, ambiguous.push(concept.id) unless ambiguous.include?(concept.id)
  end
  
  def ambiguities
    ambiguous.blank? ? [] : Concept.find(*ambiguous).to_a
  end
  
  def remove_duplicate_ambiguities # not sure but i think disambiguate_with might make duplicate entries and I don't want to check before every insert
    # maybe I should though, that method is meant to be slow anyway and i might as well keep the data clean and remove the need for this extra maintenance method
    raise NotImplemented
  end
  
  def cached_rails
    rails_ids.blank? ? [] : Concept.find(*rails_ids).to_a
  end
  
  def cached_ties
    ties_ids.blank? ? [] : Concept.find(*ties_ids).to_a
  end
  
  def cached_rail_rs
    rail_rs_ids.blank? ? [] : Railevance.find(*rail_rs_ids).to_a
  end
  
  def cached_tie_rs
    tie_rs_ids.blank? ? [] : Railevance.find(*tie_rs_ids).to_a
  end
  
  def cached_concept_ids
    (ties_ids || []) + (rails_ids || [])
  end
  
  def cached_railevance_ids
    (tie_rs_ids || []) + (rail_rs_ids || [])
  end
  
  def cache_connections set
    set.each { |k, v| cache_connection((k.to_s + 's_ids').to_sym, v) }
  end
  
  def cache_connection collection, connected_id
    existing = send(collection) || []
    update_attribute collection, existing.push(connected_id) unless existing.include?(connected_id)
  end
  
  def cache_uri
    self.uri = content[0..75].urlize if uri_distinct_from_content?
  end
  
  def uri_distinct_from_content?
    content != content[0..75].urlize
  end
  
  def set_empty_character
    self.character = {} if character.blank? && character != {}
  end
  
  def effective_uri
    uri || content
  end
  
  def self.find_by_effective_uri(e_uri)
    find_by_content(e_uri) || find_by_uri(e_uri) || find(e_uri)
  end
  
  def to_param
    effective_uri
  end
end
class Dependency < Concept
end
class Combination < Concept
end
class Trait < Concept
end
class Compatibility < Concept
end
class Directory < Concept
end
class Library < Concept
end
class Api < Concept
end
class Feature < Concept
end
class Release < Concept
end
class Version < Concept
end
class License < Concept
end
class Script < Concept
end
class Phile < Concept
end
class Klass < Concept
end
class Project < Concept
end
class Revision < Concept
end
class Incompatibility < Concept
end
class Block < Concept
end
class Line < Concept
end
class Mojule < Concept
end
class Keyword < Concept
end
class Tool < Concept
end
class Command < Concept
end
class Recipe < Concept
end
class Routine < Concept
end
class Methid < Concept
end
class Variable < Concept
end
class Constant < Concept
end
class Expression < Concept
end
class Strin < Concept
end
class Statement < Concept
end
class Join < Concept
end
class Snippet < Concept
end
class Example < Concept
end
class Argument < Concept
end
class Structure < Concept
end
class Symbl < Concept
end
class Alias < Concept
end
class Query < Concept
end
# class Benchmark < Concept
# end
class Output < Concept
end
class Route < Concept
end
class Word < Concept
end
class Dataset < Concept
end
class Datapoint < Concept
end
class Assignment < Concept
end
class Return < Concept
end
class Interaction < Concept
end
class Debate < Concept
end
class History < Concept
end
class Convention < Concept
end
class Sintax < Concept
end
class Language < Concept
end
class Regularexpression < Concept
end
class Title < Concept
end
class Capability < Concept
end
class Behavior < Concept
end
class Bounty < Concept
end
class Bug < Concept
end
class Tracker < Concept
end
class Speck < Concept
end
class Log < Concept
end
class Report < Concept
end
class Duration < Concept
end
class Outofdate < Concept
end
class Answer < Concept
end
class Question < Concept
end
class Goal < Concept
end
class Prediction < Concept
end
class Expertise < Concept
end
class Group < Concept
end
class Event < Concept
end
class Vehicle < Concept
end
class Place < Concept
end
class Plan < Concept
end
class Moment < Concept
end
class Day < Concept
end
class Year < Concept
end
class Gig < Concept
end
class Company < Concept
end
class Offer < Concept
end
class Picture < Concept
end
class Audio < Concept
end
class Vid < Concept
end
class Series < Concept
end
class Presentation < Concept
end
class Refactor < Concept
end
class Critique < Concept
end
class Compliment < Concept
end
class Opinion < Concept
end
class Strategy < Concept
end
class Aggregator < Concept
end
class Blog < Concept
end
class Post < Concept
end
class Comment < Concept
end
class Site < Concept
end
class Link < Concept
end
class Resource < Concept
end
class Search < Concept
end
class Correction < Concept
end
class Optimization < Concept
end
class Contribution < Concept
end
class Suggestion < Concept
end
class Recommendation < Concept
end
class Reference < Concept
end
class Book < Concept
end
class Topic < Concept
end
class Pattern < Concept
end
class Course < Concept
end
class Chapter < Concept
end
class Page < Concept
end
class Tip < Concept
end
class Thought < Concept
end
class Idea < Concept
end
class Summary < Concept
end
class Extension < Concept
end
class Tesst < Concept
end
class Decision < Concept
end
class Conclusion < Concept
end
class Reason < Concept
end
class Disagreement < Concept
end
class Experiment < Concept
end
class Lesson < Concept
end
class Exercise < Concept
end
class Template < Concept
end
class Abstraction < Concept
end
class Implementation < Concept
end
class Wish < Concept
end
class Preference < Concept
end
class Alternative < Concept
end
class Frustratedattempt < Concept
end
class Email < Concept
end
class Message < Concept
end
class Listserv < Concept
end
class Forum < Concept
end
class Irc < Concept
end
class Phone < Concept
end
class Call < Concept
end
class Visit < Concept
end
class Host < Concept
end
class Traffic < Concept
end
class Metaphordefinition < Concept
end
class Translation < Concept
end
class Equivalence < Concept
end
class Person < Concept
end