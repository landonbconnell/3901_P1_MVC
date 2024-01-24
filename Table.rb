require_relative './Card.rb'

class Table
    def generateDeck
        deck_size = 81
        deck = Array.new deck_size

        for i in 0...deck_size
            deck[i] = i + 1
        end

        deck = deck.shuffle
        return deck
    end

    def draw(num_cards)
        if @deck.length >= num_cards
            for i in 0...num_cards
                @cards.push @deck.pop
            end
        end
    end

    def initialize
        @deck = generateDeck
        @cards = Array.new
        draw 12

    def removeSet
        puts "Removing set..."
    end

    def deck; @deck; end
    def cards; @cards; end
end

# table = Table.new
# table.draw 3
# puts "deck: "
# puts table.deck
# puts "cards: "
# puts table.cards
end