class Player
  class Attacking
    include Node

    def initialize(parent)
      puts "ATACKING"
      @parent = parent
    end

    def can_attack?
      false
    end
  end
end
