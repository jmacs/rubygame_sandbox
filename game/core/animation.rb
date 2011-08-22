module Game::Core
  
  class Animation
    
    attr_accessor :speed
    attr_reader :sprite_info
    attr_reader :frame_index
    attr_reader :current_animation
    attr_reader :frame_time_counter
    attr_reader :rect
    attr_reader :loaded
    
    def load(script)
      @sprite_info = script[:sprite]
      @frame_time_counter = 0
      @rect = Rubygame::Rect.new 0,0,1,1
      change sprite_info[:animations].keys[0]
      @loaded = true
      @speed = 1 
    end
    
    def change(animation_name)
      return if animation_name == @current_animation_name
      @current_animation_name = animation_name
      @frame_index = 0
    end
    
    def animate()
      return if @current_animation_name.nil?
      return if num_of_frames == 1
      frame_time = current_frame_time
      @frame_time_counter += 1 * @speed
      if @frame_time_counter >= frame_time
        move_next_frame
        @frame_time_counter = 0
      end
    end
    
    def blit(surface, pos)
      surf = Game::Core::SpriteSheetManager.load sheet_name, current_frame, @rect
      surf.blit surface, pos, @rect
    end
    
    def w
      @sprite_info[:size][0]
    end
    
    def h
      @sprite_info[:size][1]
    end
    
    def sheet_name
      @sprite_info[:sheet]
    end
    
    def current_frame_key
      @sprite_info[@frame_index]  
    end
    
    def current_frame
      current_animation[:frames][@frame_index]  
    end
    
    def num_of_frames
      current_animation[:frames].size
    end
    
    def current_frame_time
      return 5 if not current_animation.has_key? :time
      current_animation[:time][@frame_index]
    end
    
    def current_animation
      @sprite_info[:animations][@current_animation_name]
    end
    
    def current_hitbox
      current_animation[:hitbox]
    end
    
    def move_next_frame
      num_of_frames = current_animation[:frames].size
      return if num_of_frames <= 1
      if @frame_index == num_of_frames - 1 
        @frame_index = 0
      else
        @frame_index += 1
      end
    end
  end
  
end