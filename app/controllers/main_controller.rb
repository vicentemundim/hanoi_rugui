# The main controller for the application.
#
# NOTE: This controller doesn't inherit from ApplicationController, instead, it
# inherits from RuGUI::BaseMainController. Use it only as a starting point.
# Commonly it is used only to register global models and controllers, as well as
# the main view, but this is entirely up to you.
class MainController < RuGUI::BaseMainController
  screen_title "Hanoi"
  
  models :hanoi

  def initialize
    super

    
    hanoi.setup(5)
    main_view.setup(screen, hanoi)

    @thread = Thread.new { hanoi.start }
  end

  def update
    main_view.refresh
  end
end
