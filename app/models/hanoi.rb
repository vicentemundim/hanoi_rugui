class Hanoi < RuGUI::BaseModel
  observable_property :left_tower, :initial_value => Tower.new(:name => 'left_tower')
  observable_property :middle_tower, :initial_value => Tower.new(:name => 'middle_tower')
  observable_property :right_tower, :initial_value => Tower.new(:name => 'right_tower')

  observable_property :towers, :initial_value => []

  observable_property :number_of_rings, :initial_value => 0
  
  observable_property :movement_interval, :initial_value => 1 # in seconds

  def setup(number_of_rings, movement_interval)
    self.reset!

    self.number_of_rings = number_of_rings
    self.movement_interval = movement_interval

    self.towers = [left_tower, middle_tower, right_tower]
    self.towers.each do |tower|
      tower.height = number_of_rings
    end

    left_tower.setup(number_of_rings)
    middle_tower.clear
    right_tower.clear
  end

  def start
    perform(number_of_rings, left_tower, right_tower, middle_tower)
  end

  def perform(number_of_rings, tower_A, tower_C, tower_B)
    if number_of_rings != 0
      perform(number_of_rings - 1, tower_A, tower_B, tower_C)
      move(tower_A, tower_C)
      perform(number_of_rings - 1, tower_B, tower_C, tower_A)
    end
  end

  def move(from_tower, to_tower)
    wait_for_next_movement
    logger.info "Moving from tower #{from_tower.name} to tower #{to_tower.name}"
    to_tower.push(from_tower.pop)
  end

  def wait_for_next_movement
    logger.info "Waiting for next movement"
    sleep movement_interval.to_f
  end
end
