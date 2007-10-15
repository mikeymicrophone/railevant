class Concept < ActiveRecord::Base
  belongs_to :railser
  has_many :railevances, :foreign_key => 'tie_id'
  has_many :rails, :through => :railevances, :source => 'rail'
  has_many :railsconcepts, :foreign_key => 'rail_id', :class_name => 'Railevance'
  has_many :ties, :through => :railsconcepts, :source => 'tie'
  validates_presence_of :content
  
  # marks all entries with identical spellings as ambiguous
  def self.disambiguate
    (c = Concept.all).remove(&:ambiguous?).each do |t|
      c.each do |s|
        t.disambiguate_with s if t.content == s.content
      end
    end
  end
  
  def disambiguate_with(concept)
    self.ambiguous = '' if ambiguous.nil?; concept.ambiguous = '' if concept.ambiguous.nil?
    self.ambiguous.concat "#{concept.id} "
    concept.ambiguous.concat "#{self.id} "
  end
  
  def remove_duplicate_ambiguities # not sure but i think disambiguate_with might make duplicate entries and I don't want to check before every insert
    # maybe I should though, that method is meant to be slow anyway and i might as well keep the data clean and remove the need for this extra maintenance method
    raise NotImplemented
  end
  
  def cached_rails
    rails_ids.blank? ? [] : ((r = Concept.find(*rails_ids.split.map(&:to_i))).is_a?(ActiveRecord::Base) ? [r] : r)
  end
  
  def cached_ties
    ties_ids.blank? ? [] : ((r = Concept.find(*ties_ids.split.map(&:to_i))).is_a?(ActiveRecord::Base) ? [r] : r)
  end
  
  def cache_tie tie_id
    self.ties_ids = (ties_ids.nil? ? tie_id.to_s : ties_ids + " #{tie_id}")
  end
  
  def cache_rail rail_id
    self.rails_ids = (rails_ids.nil? ? rail_id.to_s : rails_ids + " #{rail_id}")
  end
  
  def to_param
    content[0..75].urlize
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