require 'gtk3'
require_relative './Model.rb'
require_relative './Controller.rb'

class View

  def initialize(model, controller)
    # Gives the View access to the Model and Controller
    @model = model
    @controller = controller
    
    # Creates the top-level Window container...
    @window = Gtk::Window.new("The Game of Set")
    # ...and an event listener that listens for the 'X' button being pressed.
    @window.signal_connect("destroy") { Gtk.main_quit }

    # Creates the main grid, which will eventually contain the button, statistic, and card sections...
    @mainGrid = Gtk::Grid.new

    # ... and adds it to the Window.
    @window.add(@mainGrid)

    # Renders the button, statistic, and card sections.
    renderButtons
    renderStats
    renderCards
  end

  def renderButtons
    buttonGrid = Gtk::Grid.new

    newGameButton = Gtk::Button.new(:label => "Start New Game")
    newGameButton.signal_connect("clicked") { @controller.startNewGame }

    drawCardsButton = Gtk::Button.new(:label => "Draw 3 Cards")
    drawCardsButton.signal_connect("clicked") { @controller.drawCards }

    buttonGrid.attach(newGameButton, 0, 0, 1, 1)
    buttonGrid.attach(drawCardsButton, 0, 1, 1, 1)

    @mainGrid.attach(buttonGrid, 0, 0, 1, 1)
  end

  def renderStats
    statsGrid = Gtk::Grid.new

    @cardsInDeckLabel = Gtk::Label.new("Cards in Deck: #{ @model.table.deck.length }")
    @setsFoundLabel = Gtk::Label.new("Sets Found: #{ @model.setsFound }")
    @scoreLabel = Gtk::Label.new("Score: #{ @model.score }")

    statsGrid.attach(@cardsInDeckLabel, 0, 0, 1, 1)
    statsGrid.attach(@setsFoundLabel, 0, 1, 1, 1)
    statsGrid.attach(@scoreLabel, 0, 2, 1, 1)

    @mainGrid.attach(statsGrid, 0, 1, 1, 1)
  end

  def renderCards
    @mainGrid.remove_column(1)

    cardGrid = Gtk::Grid.new

    rows = 3
    cards = @model.table.cards
    cardsPerRow = cards.length / rows

    cards.each_with_index do |card, index|
        currentColumn = index % cardsPerRow
        currentRow = index / cardsPerRow 
        cardButton = Gtk::Button.new(:label => card.to_s)
        cardButton.signal_connect("clicked") { puts "clicked" }
        cardGrid.attach(cardButton, currentColumn, currentRow, 1, 1)
    end

    @mainGrid.attach(cardGrid, 1, 0, 1, 1)
    @window.show_all
  end

  def updateCardsInDeck
    @cardsInDeckLabel.set_text("Cards in Deck: #{ @model.table.deck.length }")
  end

  def updateSetsFound
    @setsFoundLabel.set_text("Sets Found: #{ @model.setsFound }")
  end

  def updateScore
    @scoreLabel.set_text("Score: #{ @model.score }")
  end
end