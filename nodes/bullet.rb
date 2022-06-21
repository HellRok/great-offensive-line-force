class Bullet
  include Node

  TILES = [
    119,
    117,
    115,
    113,
  ]

  def initialize(x_position, colour)
    @speed = 300
    @destination = Rectangle.new(
      x_position, 700,
      64, 64
    )
    @origin = Vector2.new(32, 32)
  end

  def render
    $tilemap.tiles.draw(
      destination: @destination,
      origin: @origin,
      source: $tilemap.tile_for(TILES.first)
    )
  end

  def update(delta)
    @destination.y += -@speed * delta

    remove_self if @destination.y <= -32
  end
end
