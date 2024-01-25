# File created 1/23/24 by Landon Connell
# Edited 1/24/24 by Landon Connell

require 'gtk3'
require_relative './Model.rb'
require_relative './Controller.rb'

class View

  # Created 1/23/24 by Landon Connell
  #   - implemented a barebones MVC GUI with "start new game"/"draw 3 cards" buttons, statistics, and 
  # Edited 1/24/24 by Landon Connell
  #   - refactored by moving button/label generation to separate functions for readibilty (renderButtons, renderStatistics, renderCards)
  def initialize(model, controller)
    # Gives the View access to the Model and Controller
    @model = model
    @controller = controller
    
    # Creates the top-level Window container...
    @window = Gtk::Window.new("The Game of Set")
    # ...and an event listener that listens for the 'X' button being pressed.
    @window.signal_connect("destroy") { Gtk.main_quit }
    @window.set_border_width(20)
    @window.override_background_color(:normal, Gdk::RGBA.new(1, 1, 1, 1))

    # Creates the main grid, which will eventually contain the button, statistic, and card sections...
    @mainGrid = Gtk::Grid.new

    # ... and adds it to the Window.
    @window.add(@mainGrid)

    # Renders the button, statistic, and card sections.
    renderButtons
    renderStats
    renderCards
  end

  # Created 1/24/24 by Landon Connell
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

  # Created 1/24/24 by Landon Connell
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

  # Created 1/24/24 by Landon Connell
  # Edited 1/24/24 by Landon Connell
  #   - sourced 27 shape/shading/color .pngs from 'https://smart-games.org/en/set/start'
  #   - generated remaining 54 variations () using a python script, and stored them in the './set_cards' directory 
  #   - simulated Set playing cards by adding an image background to the card buttons and giving them a fixed size
  def renderCards
    @mainGrid.remove_column(1)

    cardGrid = Gtk::Grid.new

    rows = 3
    cards = @model.table.cards
    cardsPerRow = cards.length / rows

    cards.each_with_index do |card, index|
        currentColumn = index % cardsPerRow
        currentRow = index / cardsPerRow 

        cardImageFile = "./set_cards/#{card.num_shapes}_#{card.shape}_#{card.shading}_#{card.color}.png"
        cardImage = Gtk::Image.new(:file => cardImageFile)
        cardButton = Gtk::Button.new()
        cardButton.set_image(cardImage)
        
        cardButton.set_size_request(100, 135)
        cardButton.set_margin_bottom(20)
        cardButton.set_margin_start(20)
        #cardButton.set_margin_end(10)

        cardButton.signal_connect("clicked") { puts "#{card.num_shapes}_#{card.shape}_#{card.shading}_#{card.color}" }

        cardGrid.attach(cardButton, currentColumn, currentRow, 1, 1)
    end

    @mainGrid.attach(cardGrid, 1, 0, 1, 1)
    @window.show_all
  end

  # Created 1/24/24 by Landon Connell
  def updateCardsInDeck
    @cardsInDeckLabel.set_text("Cards in Deck: #{ @model.table.deck.length }")
  end

  # Created 1/24/24 by Landon Connell
  def updateSetsFound
    @setsFoundLabel.set_text("Sets Found: #{ @model.setsFound }")
  end

  # Created 1/23/24 by Landon Connell
  def updateScore
    @scoreLabel.set_text("Score: #{ @model.score }")
  end
end