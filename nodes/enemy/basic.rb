class Enemy
  class Basic
    include Node

    attr_accessor :destination

    TILE = 148

    def initialize(pattern)
      @speed = 100
      @destination = Rectangle.new(
        0, 100,
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

      remove_self if @destination.y >= 660
    end
  end
end
