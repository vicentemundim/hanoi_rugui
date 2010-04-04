class RingView < RuGUI::BaseView
  include Rubygame::Sprites::Sprite

  BASE_WIDTH = 20
  BASE_HEIGHT = 20

  def setup(ring)
    @image = Rubygame::Surface.new([width(ring), BASE_HEIGHT])
    @image.fill(:blue)
    @image.draw_box([0, 0], [width(ring)-1, BASE_HEIGHT-1], :black)
    @rect = @image.make_rect
  end

  def width(ring)
    BASE_WIDTH * ring.size
  end
end
