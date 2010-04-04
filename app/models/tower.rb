class Tower < RuGUI::BaseModel
  observable_property :rings, :initial_value => []

  observable_property :height, :initial_value => 0

  observable_property :name, :prevent_reset => true

  def setup(number_of_rings)
    number_of_rings.downto(1) do |size|
      self.rings << Ring.new(:size => size)
    end
  end

  def clear
    rings.clear
  end

  def push(ring)
    rings.push(ring)
  end

  def pop
    rings.pop
  end
end
