class Spawner
  include Node

  # [ { type: :basic, column: 1, time: 3, args: [:normal] } ]
  def initialize(wave)
    @wave = wave
    @timer = 0
  end

  def update(delta)
    @timer += delta

    @wave.each { |wave|
      if wave[:time] <= @timer
        spawn wave
        @wave.delete wave
      end
    }
  end

  def spawn(wave)
    enemy = klass_for(wave[:type]).new(*wave[:args])
    enemy.position = (wave[:column] * 64) - 16
    @parent.enemies << enemy
    @parent.add_child enemy
  end

  def klass_for(type)
    case type
    when :basic
      Enemy::Basic
    end
  end

  def teardown
    scene.enemies.delete(self)
  end
end
