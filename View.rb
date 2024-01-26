# File created 1/23/24 by Landon Connell
# Edited 1/24/24 by Landon Connell
# Edited 1/25/24 by Landon Connell - wrote documentation

require 'gtk3'
require_relative './Model.rb'
require_relative './Controller.rb'

# Implements the GUI for the card game 'Set', i.e. the 'V' in the 'MVC' framework.
class View

  # Created 1/23/24 by Landon Connell
  #   - Implemented a barebones GUI with "Start New Game"/"Draw 3 Cards" buttons, statistics, and buttons representing cards
  # Edited 1/24/24 by Landon Connell
  #   - Refactored by moving button/label generation to separate functions for readabilty (renderButtons, renderStatistics, renderCards)
  def initialize(model, controller)
    # Gives the View access to the Model and Controller
    @model = model
    @controller = controller
    
    # Creates the top-level Window container,
    # an event listener that listens for the 'X' button being pressed,
    # and sets the default border width.
    @window = Gtk::Window.new("The Game of Set")
    @window.signal_connect("destroy") { Gtk.main_quit }
    @window.set_border_width(20)

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
    # Initialize a grid to hold the buttons
    buttonGrid = Gtk::Grid.new

    # Creating a 'Start New Game' button that calls the .startNewGame function when clicked
    newGameButton = Gtk::Button.new(:label => "Start New Game")
    newGameButton.signal_connect("clicked") { @controller.startNewGame }

    # Creating a 'Draw 3 Cards' button that calls the .drawCards function when clicked
    drawCardsButton = Gtk::Button.new(:label => "Draw 3 Cards")
    drawCardsButton.signal_connect("clicked") { @controller.drawCards }

    # Attach the buttons to the button grid
    buttonGrid.attach(newGameButton, 0, 0, 1, 1)
    buttonGrid.attach(drawCardsButton, 0, 1, 1, 1)

    # Attach the button grid to the main grid (in a 2x2 grid, top left)
    @mainGrid.attach(buttonGrid, 0, 0, 1, 1)
  end

  # Created 1/24/24 by Landon Connell
  def renderStats
    # Initialize a grid to hold the statistics
    statsGrid = Gtk::Grid.new

    # Create labels for that shows how many cards are in the deck, how many sets have been found, and the player's score.
    @cardsInDeckLabel = Gtk::Label.new("Cards in Deck: #{ @model.table.deck.length }")
    @setsFoundLabel = Gtk::Label.new("Sets Found: #{ @model.setsFound }")
    @scoreLabel = Gtk::Label.new("Score: #{ @model.score }")

    # Attach the statistics to the stats grid
    statsGrid.attach(@cardsInDeckLabel, 0, 0, 1, 1)
    statsGrid.attach(@setsFoundLabel, 0, 1, 1, 1)
    statsGrid.attach(@scoreLabel, 0, 2, 1, 1)

    # Attach the stats grid to the main grid (in a 2x2 grid, bottom left)
    @mainGrid.attach(statsGrid, 0, 1, 1, 1)
  end

  # Created 1/24/24 by Landon Connell
  # Edited 1/24/24 by Landon Connell
  #   - sourced 27 shape/shading/color .pngs from 'https://smart-games.org/en/set/start'
  #   - generated remaining 54 variations () using a python script, and stored them in the './set_cards' directory 
  #   - simulated Set playing cards by adding an image background to the card buttons and giving them a fixed size
  def renderCards
    # If cards are already present, remove them so they can be re-rendered as the model changes.
    @mainGrid.remove_column(1)

    # Initialize a grid to hold the cards.
    cardGrid = Gtk::Grid.new

    # We want the cards to be displayed in three rows, so calculate the number of cards in each row.
    rows = 3
    cards = @model.table.cards
    cardsPerRow = cards.length / rows

    # Generate a button for every card currently on the table
    cards.each_with_index do |card, index|

      # Create a button for the current card
      cardButton = Gtk::Button.new()

      # Calculate the current row and column in the grid where the card will be displayed
      currentRow = index / cardsPerRow # 0 <= currentRow <= 2
      currentColumn = index % cardsPerRow # 0 <= currentColumn < cardsPerRow
      
      # Get the image corresponding to the current card
      cardImageFile = "./set_cards/#{card.num_shapes}_#{card.shape}_#{card.shading}_#{card.color}.png"
      cardImage = Gtk::Image.new(:file => cardImageFile)
      
      # Set the image as the card button's background
      cardButton.set_image(cardImage)
      
      # Resize buttons so they're card-shaped and space them apart
      cardButton.set_size_request(100, 135)
      cardButton.set_margin_bottom(20)
      cardButton.set_margin_start(20)

      # Make it call the .clickCard method when clicked
      cardButton.signal_connect("clicked") { @controller.clickCard(card) }

      # Attach card to cardGrid at the current column/row
      cardGrid.attach(cardButton, currentColumn, currentRow, 1, 1)
    end

    # Attach the card grid to the main grid (in a 2x2 grid, top right)
    @mainGrid.attach(cardGrid, 1, 0, 1, 1)

    # Refresh the window to show most up-to-date version of all widgets
    # It belongs here instead of inside the constructor, because this part of the main grid needs to be constantly re-rendered
    @window.show_all
  end

  # Created 1/23/24 by Landon Connell
  def updateCardsInDeck
    # Syncs "Cards in Deck" label with current data from the model
    @cardsInDeckLabel.set_text("Cards in Deck: #{ @model.table.deck.length }")
  end

  # Created 1/23/24 by Landon Connell
  def updateSetsFound
    # Syncs "Sets Found" label with current data from the model
    @setsFoundLabel.set_text("Sets Found: #{ @model.setsFound }")
  end

  # Created 1/23/24 by Landon Connell
  def updateScore
    # Syncs "Score" label with current data from the model
    @scoreLabel.set_text("Score: #{ @model.score }")
  end
end