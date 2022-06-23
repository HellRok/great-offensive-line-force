class Defeat
  include Scene

  def initialize
    @texture = Texture2D.load('./assets/defeat.png')
    @destination = Rectangle.new(
      240 - (@texture.width / 2), 400 - (@texture.height / 2),
      @texture.width, @texture.height
    )
  end

  def setup
    add_child FadeIn.new(2) {
      add_child Delay.new(length: 3) {
        puts "LOL"
      }
    }
  end

  def render
    @texture.draw(destination: @destination)
  end
end
