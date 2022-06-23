class Explosion
  include Node

  TILE = 109

  def initialize(destination)
    @timer = 0
    @duration = 1

    @destination = destination
    @origin = Vector2.new(32, 32)
    @colour = Colour.new(255, 255, 255, opacity)
  end

  def update(delta)
    @timer += delta
    @colour.alpha = opacity

    remove_self if @timer >= @duration
  end

  def render
    $tilemap.tiles.draw(
      destination: @destination,
      origin: @origin,
      source: $tilemap.tile_for(TILE),
      colour: @colour
    )
  end

  def opacity
    255 - (255 * (@timer / @duration))
  end
end
