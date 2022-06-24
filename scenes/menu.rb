class Menu
  include Scene
  def setup
    @title = Texture2D.load('./assets/title.png')
    @title_destination = Rectangle.new(
      240 - (@title.width / 2), 20,
      @title.width, @title.height
    )

    add_child Button.new(
      'Play',
      120, 300,
      240, 60
    ) { start 1 }

    @jump = Texture2D.load('./assets/jump_to.png')
    @jump_destination = Rectangle.new(
      -32, 370,
      @jump.width, @jump.height
    )

    add_child Button.new(
      '2',
      200, 400,
      60, 60
    ) { start 2 }

    add_child Button.new(
      '3',
      270, 400,
      60, 60
    ) { start 3 }

    add_child Button.new(
      '4',
      340, 400,
      60, 60
    ) { start 4 }

    add_child Button.new(
      '5',
      410, 400,
      60, 60
    ) { start 5 }

    add_child Button.new(
      'What\'s Taylor?',
      120, 480,
      240, 60
    ) { open_url 'http://taylor.oequacki.com' }

    unless browser?
      add_child Button.new(
        'Exit',
        120, 560,
        240, 60
      ) { exit }
    end

    @wall = Wall.new
    add_child @wall
    @map_destination = Rectangle.new(-16, -16, 64 * 8, 64 * 13)

    add_child(FadeIn.new(0.5){})
  end

  def render
    $map_base.draw(destination: @map_destination)
    $map_flavour.draw(destination: @map_destination)
    @title.draw(destination: @title_destination)
    @jump.draw(destination: @jump_destination)
  end

  def start(wave)
    add_child FadeOut.new(0.5) {
      $scene_manager.switch_to(Game.new(wave))
    }
  end
end
