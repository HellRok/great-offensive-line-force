class Game
  include Scene

  def setup
    @player = Player.new
    add_child @player

    @map_destination = Rectangle.new(-16, -16, 64 * 8, 64 * 13)
  end

  def render
    $map_base.draw(destination: @map_destination)
    $map_flavour.draw(destination: @map_destination)
    $map_wall.draw(destination: @map_destination)
  end

  def update(delta)

    if $input.left_down?
      @player.move :left, delta
    elsif $input.right_down?
      @player.move :right, delta
    end
  end
end
