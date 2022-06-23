class Victory
  include Scene

  def initialize
    @victory = Texture2D.load('./assets/victory.png')
    @victory_destination = Rectangle.new(
      240 - (@victory.width / 2), 20,
      @victory.width, @victory.height
    )

    @credits = Texture2D.load('./assets/credits.png')
    @credits_destination = Rectangle.new(
      240 - (@credits.width / 2), 200,
      @credits.width, @credits.height
    )

    @thanks = Texture2D.load('./assets/thanks.png')
    @thanks_destination = Rectangle.new(
      240 - (@thanks.width / 2), 800 - 360,
      @thanks.width, @thanks.height
    )
  end

  def setup
    add_child FadeIn.new(2) { }
  end

  def render
    $map_base.draw(destination: @map_destination)
    $map_flavour.draw(destination: @map_destination)
    $map_wall_low.draw(destination: @destination)

    @victory.draw(destination: @victory_destination)
    @credits.draw(destination: @credits_destination)
    @thanks.draw(destination: @thanks_destination)
  end
end
