module Game::Views

  class HudView < Game::Core::View
    
    def initialize
      super
    end
    
    def loading
      @surface = Rubygame::Surface.load("./resource/img/hud_bk.png")
      
    end
    
    def update(seconds, clock)
      
    end
   
    def draw(surface)
      @surface.blit surface, [0,408]
    end
    
   end
    
end