require "game/core/vector2"

module Game::Core
  
  class CollisionHitbox
  
    attr_reader :colliding_with
    attr_reader :collidable
    attr_reader :hitboxes
    attr_reader :current
    
    def initialize
      @colliding_with = []
      @collidable = true
    end
    
    def name
      @current[0]
    end
    
    def rect
      @current[1]
    end
    
    def offset
      @current[2]
    end
    
    def image
      @current[3]
    end
    
    def load(script)
      @hitboxes = Hash.new
      script[:sprite][:hitbox].each do |key,hitbox|
        r = Rubygame::Rect.new 0,0, hitbox[:size][0], hitbox[:size][1]
        o = Vector2.new hitbox[:offset][0], hitbox[:offset][1]
        @hitboxes[key] = [key,r,o,nil]
      end
      @current = @hitboxes[@hitboxes.keys[0]]
    end
    
    def change(key)
      return if name == key
      @current = @hitboxes[key]
    end
    
    def w
      rect.w
    end
    
    def h
      rect.h
    end
    
    def top
      rect.top
    end
    
    def bottom
      rect.bottom
    end
    
    def right
      rect.right
    end
      
    def left
      rect.left  
    end
    
    def make_visible
      @hitboxes.each do |key,box|
        img = Rubygame::Surface.new([box[1].w, box[1].h])
        img.set_alpha 100
        img.fill([100, 100, 100])
        box[3] = img
      end
    end
    
    def clear_colliding_objects
      @colliding_with.clear
    end
    
    def collide_with(object)
      if not @colliding_with.include? object
        @colliding_with << object
      end
    end
    
    def colliding?
      @colliding_with.size > 0
    end
    
    def colliding_with?(object)
      @colliding_with.include? object
    end
    
    def collidable?
      return false if @current.nil?
      @collidable
    end
    
    def collision_detected?(hitbox)
      colliding = rect.collide_rect? hitbox.rect
      color_rect colliding
      return colliding
    end
    
    def color_rect(colliding)
      if visible? then
        if colliding then
          image.fill([178,34,34])
        else
          image.fill([100, 100, 100])
        end
      end
    end
    
    def enable_collision
      @collidable = true
    end
    
    def disable_collision
      @collidable = false
    end
    
    def update(pos)
      c = pos + offset
      rect.center = c.to_a
    end
    
    def blit(surface, pos)
      return if not visible?
      image.blit surface, rect
    end
    
    def visible?
      image.nil? == false
    end
    
  end
  
end