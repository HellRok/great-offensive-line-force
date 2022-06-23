class Wave
  include Node

  def initialize(count, &block)
    @texture = Texture2D.load("./assets/wave_#{count}.png")

    @hidden = false

    @destination = Rectangle.new(
      240 - (@texture.width / 2), 400 - (@texture.height / 2),
      @texture.width, @texture.height
    )

    add_child Delay.new(length: 0.5) { @hidden = !@hidden }
    add_child Delay.new(length: 1.0) { @hidden = !@hidden }
    add_child Delay.new(length: 1.5) { @hidden = !@hidden }
    add_child Delay.new(length: 2.0) { @hidden = !@hidden }
    add_child Delay.new(length: 2.5) {
      block.call
      remove_self
    }
  end

  def render
    unless @hidden
      @texture.draw(
        destination: @destination
      )
    end
  end
end
