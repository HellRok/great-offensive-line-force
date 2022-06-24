class Button
  include Node
  def initialize(text, x, y, width, height, &block)
    @text = text
    @rectangle = Rectangle.new(x, y, width, height)
    @hover = false
    @block = block
    @event_fired = false

    @text_position = Vector2.new(
      @rectangle.x + ((@rectangle.width - text_width) / 2),
      @rectangle.y + ((@rectangle.height - Theme::FONT.base_size) / 2)
    )
  end

  def update(_delta)
    @hover = hover?

    if hover? && !@event_fired && mouse_button_pressed?(MOUSE_LEFT_BUTTON)
      @event_fired = true
      @block.call
    end
  end

  def render
    draw_rectangle_rec(@rectangle, background_colour)
    draw_rectangle_lines_ex(@rectangle, 2, border_colour)
    Theme::FONT.draw(
      @text,
      position: @text_position,
      size: Theme::FONT.base_size,
      colour: Theme::Colour::TERTIARY
    )
  end

  def hover?
    @event_fired || check_collision_point_rec(get_mouse_position, @rectangle)
  end

  def background_colour
    @hover ? Theme::Colour::SECONDARY : Theme::Colour::QUINARY
  end

  def border_colour
    Theme::Colour::PRIMARY
  end

  def text_width
    Theme::FONT.measure(@text, size: Theme::FONT.base_size).x
  end
end
