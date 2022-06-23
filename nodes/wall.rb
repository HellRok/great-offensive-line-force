class Wall
  include Node

  attr_accessor :health

  def initialize
    @destination = Rectangle.new(-16, -16, 64 * 8, 64 * 13)
    @health = 9
  end

  def render
    if @health > 6
      $map_wall_full.draw(destination: @destination)
    elsif @health > 3
      $map_wall_some.draw(destination: @destination)
    elsif @health > 0
      $map_wall_low.draw(destination: @destination)
    end
  end
end
