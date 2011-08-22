require "./game/core/animation_frame_set.rb"

module Game::Core
  
  class Animation
    
    attr_reader :current
    
    def load(script)
      @frame_time_counter = 0
      @speed = 1 
      @rect = Rubygame::Rect.new 0,0,1,1
      @sets = Hash.new
      @sheet = nil
      @sheet_name = script[:sprite][:sheet]
      create_frame_sets script[:sprite][:animation]
      update_blit_area
    end
    
    def change(animation_name)
      return if @current.name == animation_name
      @current = @sets[animation_name]
      @current.reset
      @frame_time_counter = 0
      update_blit_area
    end
    
    def set_speed(speed)
      @speed = speed
    end
    
    def animate()
      @frame_time_counter += 1 * @speed
      if @frame_time_counter >= @current.frame_time
        @current.next
        @frame_time_counter = 0
        update_blit_area
      end
    end
    
    def blit(surface, pos)
      @sheet.blit surface, pos, @rect
    end
    
    def w
      @rect.w
    end
    
    def h
      @rect.h
    end
    
    def hitbox
      @current.frame_hitbox
    end
    
    private
    
    def create_frame_sets(animations)
      animations.each do |name,hash|
        set = AnimationFrameSet.new name, hash
        @sets[set.name] = set
      end
      @current = @sets[@sets.keys[0]]
    end
    
    def update_blit_area
      @sheet = Game::Core::SpriteSheetManager.load @sheet_name, @current.frame_name, @rect
    end
    
  end
  
end