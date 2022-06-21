class Game
  include Scene

  def setup
    @player = Player.new
    add_child @player

    add_child Spawner.new [
      { type: :basic, column: 1, time: 3, args: [:normal] },
      { type: :basic, column: 2, time: 4, args: [:normal] },
      { type: :basic, column: 3, time: 5, args: [:normal] },
    ]

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
