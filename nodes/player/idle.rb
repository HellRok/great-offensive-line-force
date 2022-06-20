class Player
  class Idle
    include Node

    def initialize(parent)
      @parent = parent
    end

    def can_attack?
      true
    end
  end
end
