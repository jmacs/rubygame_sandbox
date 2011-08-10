require "./game/core/goid.rb"
require "./game/core/collision_hitbox.rb"

module Game::Core

  class GameObject
    
    attr_reader :pos
    attr_reader :size
    attr_reader :goid
    attr_reader :hitbox
    
    def initialize(pos, size)
      @pos = pos
      @size = size
      @goid = GOID.next
      @hitbox = CollisionHitbox.new pos, size
    end
    
    def update  
      #implement in sub class  
    end
    
    def draw(surface)
      #implement in sub class
    end
    
    def move(pos)
      @pos = pos
      @hitbox.center @pos
    end
    
    def shift(pos)
      @pos[0] = @pos[0] + pos[0]
      @pos[1]  = @pos[1] + pos[1]
      @hitbox.center [@pos[0], @pos[1]]
    end
    
  end

end