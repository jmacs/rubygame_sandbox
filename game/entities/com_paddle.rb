require "./game/core/entity.rb"

module Game::Entities

  class ComPaddle < Game::Core::Entity
    
    MOVE_SPEED = 5.0
    
    def initialize(pos)
      @actor = load_script "paddle"
      super pos, @actor[:hitbox]
    end
    
    def load
      @image = Rubygame::Surface.new [35,150]
      @image.fill :white
      @hitbox.make_visible
      @ball_reset = true
      @dir = [0,0]
      @input = Game::Core::PlayerInput
    end
    
    def update
      move_toward_ball
    end
    
    def draw
      @hitbox.draw @view.surface, screen_pos
      @image.blit @view.surface, screen_pos
    end
   
    def move_toward_ball
      if @view.ball.pos[1] > @pos[1] then
        move [-@pos[0], -@pos[1] - MOVE_SPEED]
      end
      if @view.ball.pos[1] < @pos[1] then
        move [@pos[0], @pos[1] + MOVE_SPEED]
      end
    end
      
   
   end
    
end