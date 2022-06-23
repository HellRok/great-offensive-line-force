class Menu
  include Scene
  def setup
    add_child Button.new(
      'Play',
      10,
      10,
      100,
      100
    ) { puts 'hi' }
  end
end
