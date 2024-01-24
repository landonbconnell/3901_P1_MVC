require_relative "./Model"
require_relative "./View"
require_relative "./Controller"

model = Model.new
controller = Controller.new model
view = View.new model, controller
controller.setView(view)

Gtk.main