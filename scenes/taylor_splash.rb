class TaylorSplash
  include Scene

  def setup
    add_child(Sprite.new(240, 400, './assets/taylor_splash.png'))
    add_child(FadeIn.new(0.5){})

    add_child(Delay.new(length: 3) {
      add_child(FadeOut.new(0.5){
        $scene_manager.switch_to(Menu.new)
      })
    })
  end
end
