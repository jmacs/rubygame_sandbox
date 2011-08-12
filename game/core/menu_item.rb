require "game/core/entity.rb"

module Game::Core
  
  class MenuItem < Entity
    
    attr_reader :selected
    attr_reader :textbox
    attr_reader :rect
    
    def initialize(pos, rect_size, text, font_size, font_color, click_callback)
      super pos, rect_size
      @selected = false
      @textbox = Game::Core::TextBox.new pos, text, font_size, font_color
      @textbox.text = text
      @image = Rubygame::Surface.new(rect_size)
      @image.fill([100, 100, 100])
      @image.set_alpha 0
      @click_callback = click_callback
    end
    
    def load
      @textbox.view = @view
    end
    
    def select
      @selected = true
      @image.set_alpha 255
    end
    
    def unselect
      @selected = false
      @image.set_alpha 0
    end
    
    def text=(value)
      @textbox.text = value
    end
    
    def draw
      @image.blit @view.surface, pos
      @textbox.draw
    end
    
    def trigger
      @click_callback.call
    end
    
  end  
  
end