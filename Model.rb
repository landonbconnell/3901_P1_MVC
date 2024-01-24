require_relative './Table.rb'

class Model
    attr_accessor :table, :selectedCards, :setsFound, :score, :duration

    def startNewGame
        @table = Table.new
        @selectedCards = []
        @setsFound = 0
        @score = 0
        @duration = 0
    end

    def initialize
        startNewGame
    end

    def increase_score
        @score += 1
    end

    def clickCard
        puts "Clicking card..."
    end

    def validateSet
        puts "Validating set..."
    end
end
