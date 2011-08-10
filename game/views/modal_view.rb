
module Game::Views

  class ModalView < Game::Core::View
    
    def initialize
      super
    end
    
    def loading
      @menu = Game::Core::Menu.new [100, 100], [100, 50], 25, [255,255,255], 14
      @menu.add_item "Ok", method(:menu_nothing_selected)
      @menu.add_item "Close", method(:menu_close_selected)
      @menu.select_by_index 0
      @background = Rubygame::Surface.new [300, 200]
      @background.fill :red
    end
    
    def update(clock)
      @menu.update clock
    end
    
    def draw(surface)
      @menu.draw @background
      @background.blit surface, [250, 250]
    end
    
    def menu_close_selected
      hide
      @parent.unfreeze
    end
    
    def menu_nothing_selected
      hide
      @parent.unfreeze
    end
   
   end
    
end