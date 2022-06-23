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

    @wall = Wall.new
    add_child @wall

    wave_1

    @map_destination = Rectangle.new(-16, -16, 64 * 8, 64 * 13)
  end

  def render
    $map_base.draw(destination: @map_destination)
    $map_flavour.draw(destination: @map_destination)
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
    @enemies.each { |enemy|
      @bullets.each { |bullet|
        if bullet.hit? enemy
          bullet.hit
          enemy.hit
        end
      }

      if enemy.destination.y >= 660
        remove_child enemy
        @wall.health -= 1
        if @wall.health <= 0
          children.each(&:pause)
          add_child FadeOut.new(2) {
            $scene_manager.switch_to(Defeat.new)
          }
        end
      end
    }
  end

  def wave_1
    add_child Wave.new 1 {
      add_child Spawner.new(WAVE_ONE) {
        wave_2
      }
    }
  end

  def wave_2
    add_child Wave.new 2 {
      add_child Spawner.new(WAVE_TWO) {
        wave_2
      }
    }
  end
end
