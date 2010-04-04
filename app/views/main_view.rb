class MainView < ApplicationView
  attr_accessor :screen
  attr_accessor :hanoi

  attr_accessor :towers
  attr_accessor :rings

  def setup(screen, hanoi)
    self.hanoi = hanoi
    self.screen = screen

    create_towers
    create_rings
  end

  def refresh
    clear
    draw_towers
    draw_rings
  end

  def clear
    screen.fill(:white)
  end

  def draw_towers
    self.towers.each_with_index do |tower_view, index|
      tower = self.hanoi.towers[index]
      rect = tower_view.setup(tower, tower_height)
      position_tower(index, rect)
      tower_view.draw(screen)
    end
  end

  def position_tower(index, rect)
    rect.left = tower_center_position(index)
    rect.top = screen.height/10
  end

  def tower_center_position(index)
    @tower_center_positions ||= {}
    @tower_center_positions[index] ||= calculate_tower_center_position(index)
  end

  def calculate_tower_center_position(index)
    edges_offset = screen.width / 10
    towers_width = screen.width - (edges_offset * 2)
    tower_rect_width = towers_width / 3
    tower_rect_left = tower_rect_width * index

    tower_rect_left + tower_rect_width/2 + edges_offset
  end

  def tower_height
    screen.height - screen.height/5
  end

  def tower_bottom
    tower_height + (screen.height/10)
  end

  def draw_rings
    self.hanoi.towers.each_with_index do |tower, tower_index|
      tower.rings.each_with_index do |ring, ring_index|
        ring_view = self.rings[ring.size]
        draw_ring(ring, ring_view, ring_index, tower_index)
      end
    end
  end

  def draw_ring(ring, ring_view, ring_index, tower_index)
    rect = ring_view.setup(ring)
    position_ring(rect, ring_index, tower_index)
    ring_view.draw(screen)
  end

  def position_ring(rect, ring_index, tower_index)
    rect.center = [ring_x(tower_index), ring_y(ring_index)]
  end

  def ring_x(tower_index)
    calculate_tower_center_position(tower_index) + TowerView::BASE_WIDTH/2
  end

  def ring_y(ring_index)
    tower_bottom - 20 - ring_index*RingView::BASE_HEIGHT
  end

  def create_towers
    self.towers = []
    3.times do
      self.towers << TowerView.new
    end
  end

  def create_rings
    self.rings = {}
    1.upto(self.hanoi.number_of_rings) do |size|
      self.rings[size] = RingView.new
    end
  end
end
