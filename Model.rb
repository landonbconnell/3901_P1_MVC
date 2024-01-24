require_relative './Table.rb'

class Model
    def startNewGame
        @table = Table.new
        @selectedCards = []
        @setsFound = 0
        @score = 0
        @duration = 0
    end

    def initialize
        startNewGame

    def increase_score
        @score += 1
    end

    def clickCard
        puts "Clicking card..."
    end

    def validateSet
        puts "Validating set..."
    end

    def table; @table; end
    def selectedCards; @selectedCards; end
    def setsFound; @setsFound; end
    def score; @score; end
    def duration; @duration; end
end
end