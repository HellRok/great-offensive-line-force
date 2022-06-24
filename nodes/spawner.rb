class Spawner
  include Node

  # [ { type: :basic, column: 1, time: 3, args: [:normal] } ]
  def initialize(wave, &block)
    @wave = wave.dup
    @timer = 0
    @block = block
  end

  def update(delta)
    @timer += delta

    @wave.each { |wave|
      if wave[:time] <= @timer
        spawn wave
        @wave.delete wave

        if @wave.size.zero?
          add_child Delay.new(length: 8) {
            @block.call
            remove_self
          }
        end
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
