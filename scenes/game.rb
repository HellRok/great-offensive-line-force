class Game
  include Scene

  attr_accessor :bullets, :enemies

  def initialize(wave)
    @bullets = []
    @enemies = []
    @wave = wave
  end

  def setup
    @player = Player.new
    add_child @player

    @wall = Wall.new
    add_child @wall

    @map_destination = Rectangle.new(-16, -16, 64 * 8, 64 * 13)

    $sounds.background_music.play
    $sounds.background_music.volume = 0.3

    add_child FadeIn.new(0.5) {
      case @wave
      when 1
        wave_1
      when 2
        wave_2
      when 3
        wave_3
      when 4
        wave_4
      when 5
        wave_5
      else
        wave_1
      end
    }
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
    elsif mouse_button_down?(MOUSE_LEFT_BUTTON)
      # This is a bit of a dodgy trick, but basically tapping acts as a mouse
      # click, but doesn't give the position, so let's just pretend it was a
      # tap and act accordingly
      if get_touch_position(0).x < 240
        @player.move :left, delta
      else
        @player.move :right, delta
      end
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
        enemy.destination.y += 16
        add_child Explosion.new(enemy.destination)
        remove_child enemy
        @wall.health -= 1
        $sounds.play(:hurt)
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
        wave_3
      }
    }
  end

  def wave_3
    add_child Wave.new 3 {
      add_child Spawner.new(WAVE_THREE) {
        wave_4
      }
    }
  end

  def wave_4
    add_child Wave.new 4 {
      add_child Spawner.new(WAVE_FOUR) {
        wave_5
      }
    }
  end

  def wave_5
    add_child Wave.new 5 {
      add_child Delay.new(length: 13) { add_child Wave.new '?' }
      add_child Delay.new(length: 19) { rescue_bullets }
      add_child Spawner.new(WAVE_FIVE) {
        add_child FadeOut.new(2) {
          $scene_manager.switch_to(Victory.new)
        }
      }
    }
  end

  def rescue_bullets
    16.times { |row|
      add_child Delay.new(length: row * 0.5) {
        (1..7).each { |index|
          bullet = Bullet.new((index * 64) - 16, :green, 816)
          @bullets << bullet
          add_child bullet
        }
      }
    }
  end
end
