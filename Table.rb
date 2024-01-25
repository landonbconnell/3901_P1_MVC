require_relative './Card.rb'

class Table
    attr_accessor :deck, :cards

    def initialize
        @deck = Array.new
        @cards = Array.new
        generateDeck
        draw 12
    end

    def generateDeck
        num_shapes = 1..3
        shapes = ["diamond", "squiggle", "oval"]
        shadings = ["solid", "striped", "open"]
        colors = ["red", "green", "blue"]

        num_shapes.each do |num|
            shapes.each do |shape|
                shadings.each do |shade|
                    colors.each do |color|
                        @deck.push Card.new(num, shape, shade, color)
                    end
                end
            end
        end

        @deck.shuffle!
    end

    def draw(num_cards)
        if @deck.length >= num_cards
            for i in 0...num_cards
                @cards.push @deck.pop
            end
        end
    end

    def removeSet
        puts "Removing set..."
    end
end