require 'nodes/player/idle'
require 'nodes/player/attacking'

class Player
  include Node
  include StateMachine

  attr_reader :speed

  state_machine(
    states: {
      idle: Player::Idle,
      attacking: Player::Attacking,
    }
  )

  BODY_TILE = 118
  HAND_TILE = 120

  def initialize
    @speed = 250
    @attack_speed = 0.5

    @body_destination = Rectangle.new(
      240, 752,
      64, 64
    )
    @origin = Vector2.new(32, 32)

    @hand_destination = Rectangle.new(
      @body_destination.x, @body_destination.y - 48,
      64, 64
    )

    idle
  end

  def add_child_callback
    shoot_bullet
  end

  def update(delta)
  end

  def render
    $tilemap.tiles.draw(
      destination: @body_destination,
      origin: @origin,
      source: $tilemap.tile_for(BODY_TILE)
    )

    $tilemap.tiles.draw(
      destination: @hand_destination,
      source: $tilemap.tile_for(HAND_TILE)
    )
  end

  def move(direction, delta)
    case direction
    when :left
      offset = -speed * delta
    when :right
      offset = speed * delta
    end

    @body_destination.x += offset
    @hand_destination.x += offset

    if @body_destination.x <= -32
      @body_destination.x = -32
      @hand_destination.x = -32
    elsif @body_destination.x >= (480 - 32)
      @body_destination.x = 480 - 32
      @hand_destination.x = 480 - 32
    end
  end

  def idle
    transition_to :idle, self
  end

  def attack
    transition_to :attacking, self if @state.can_attack?
  end

  def shoot_bullet
    add_child Bullet.new(@body_destination.x + 32, :green)
    add_child Delay.new(length: @attack_speed) { shoot_bullet }
  end
end
