class Enemy
  class Basic
    include Node

    attr_accessor :destination

    TILE = 148

    def initialize(pattern)
      @pattern = pattern
      @speed = 100
      @destination = Rectangle.new(
        0, -64,
        64, 64
      )
      @origin = Vector2.new(32, 32)
    end

    def render
      $tilemap.tiles.draw(
        destination: @destination,
        origin: @origin,
        source: $tilemap.tile_for(TILE)
      )
    end

    def update(delta)
      @destination.y += @speed * delta

      case @pattern
      when :sin
        @destination.x = @original_x_position + Math.sin(@destination.y / 20.0) * 64
      end
    end

    def teardown
      scene.enemies.delete(self)
    end

    def hit
      $sounds.play :explosion
      scene.add_child Explosion.new(destination)
      remove_self
    end

    def position=(x_position)
      @original_x_position = x_position
      @destination.x = x_position
    end
  end
end
