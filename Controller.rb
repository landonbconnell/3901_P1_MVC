require_relative 'Model.rb'
require_relative 'View.rb'

class Controller
    def initialize(model)
        @model = model
    end

    def setView(view)
        @view = view
    end

    def syncModelAndView
        @view.renderCards
        @view.updateScore
        @view.updateCardsInDeck
        @view.updateSetsFound
    end

    def drawCards
        @model.table.draw 3
        @view.renderCards
        @view.updateCardsInDeck
    end

    def increaseScore
        @model.increase_score
        @view.updateScore
    end

    def startNewGame
        @model.startNewGame
        syncModelAndView
    end    
end
