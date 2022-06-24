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
    add_child FadeIn.new(2) { }
    $sounds.play(:defeat)
    add_child Delay.new(length: 1) { $sounds.play(:defeat) }
    add_child Delay.new(length: 2) { $sounds.play(:defeat) }
    add_child Delay.new(length: 3) { $sounds.play(:defeat) }
    add_child Delay.new(length: 4) { $sounds.play(:defeat) }
    add_child Delay.new(length: 5) {
      $scene_manager.switch_to(Menu.new)
    }
  end

  def render
    @texture.draw(destination: @destination)
  end
end
