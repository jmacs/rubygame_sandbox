require "./game/core/entity.rb"

include Game::Core

module Game::Entites

  class Planet < Entity
    
    def initialize(px, py, actor)
      super px, py
      @image = Surface.load(actor[:sprite][:path])
      @hitbox.create_rect(px, py, @image.w, @image.h)
      @angle = 2*Math::PI * rand
    end
    
    def update(seconds)
      handle_movement seconds
    end
    
    def draw(screen)
      @image.blit(screen, [@px, @py])
    end
    
    def handle_movement(seconds)
      @angle = ( @angle + 2*Math::PI / 4 * seconds) % ( 2*Math::PI)
      direction = [Math.sin(@angle), Math.cos(@angle)]
      if(direction[0] != 0 || direction[1] != 0)
        move direction[0], direction[1] 
      end
    end
      
  end

end