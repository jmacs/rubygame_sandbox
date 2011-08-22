module Game::Core
  
  class AnimationFrameSet
    
    HITBOX_KEY = :hitbox
    TIME_KEY = :time
    DEFAULT_HITBOX = :default
    DEFAULT_TIME = 5
    
    attr_reader :name
    
    def initialize(name, hash)
      @name = name
      @hash = hash
      @keys = hash.keys
      @frame_count = @keys.size
      @index = 0
    end
    
    def reset
      @index = 0
    end
    
    def next
      return if @frame_count <= 1
      if @index == @frame_count - 1
        @index = 0
      else
        @index += 1
      end
    end
    
    def frame_name
      @keys[@index]
    end
    
    def frame_hitbox
      if @hash[frame_name].key? HITBOX_KEY
        return @hash[frame_name][HITBOX_KEY]  
      end
      return DEFAULT_HITBOX
    end
    
    def frame_time
      if @hash[frame_name].key? TIME_KEY
        return @hash[frame_name][TIME_KEY]  
      end
      return DEFAULT_TIME
    end
    
  end
  
end