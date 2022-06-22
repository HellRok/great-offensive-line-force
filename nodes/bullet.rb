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

  def teardown
    scene.bullets.delete(self)
  end

  def hit?(enemy)
    enemy_position = Vector2.new(enemy.destination.x + 32, enemy.destination.y + 32)
    bullet_position = Vector2.new(@destination.x + 32, @destination.y + 32)

    if (enemy_position - bullet_position).length < 32
      true
    end
  end

  def hit
    remove_self
  end
end
