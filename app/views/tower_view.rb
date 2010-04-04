class TowerView < RuGUI::BaseView
  include Rubygame::Sprites::Sprite

  BASE_WIDTH = 4

  def setup(tower, height)
    @image = Rubygame::Surface.new([width(tower), height])
    @image.fill(:red)
    @image.draw_box([0, 0], [width(tower)-1, height-1], :black)
    @rect = @image.make_rect
  end

  def width(tower)
    BASE_WIDTH
  end
end
