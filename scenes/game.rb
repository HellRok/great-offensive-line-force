class Game
  include Scene

  attr_accessor :bullets, :enemies

  def initialize
    @bullets = []
    @enemies = []
  end

  def setup
    @player = Player.new
    add_child @player

    add_child Spawner.new [
      { type: :basic, column: 3, time: 1, args: [:sin] },
      { type: :basic, column: 3, time: 1.25, args: [:sin] },
      { type: :basic, column: 3, time: 1.5, args: [:sin] },
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

    check_collisions
  end

  def check_collisions
    @bullets.each { |bullet|
      @enemies.each { |enemy|
        if bullet.hit? enemy
          bullet.hit
          enemy.hit
        end
      }
    }
  end
end
