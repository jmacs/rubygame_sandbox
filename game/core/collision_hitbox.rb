
module Game::Core
  
  class CollisionHitbox
  
    attr_reader :colliding_with
    attr_reader :collidable
    attr_reader :rect
    attr_reader :regions
    attr_reader :sizes
    attr_reader :current_size
    
    def initialize
      @rect = Rubygame::Rect.new(0,0, 0, 0)
      @colliding_with = []
      @collidable = true
      @regions = Hash.new
      @region_collisions = []
    end
    
    def load(script)
      @sizes = script[:sprite][:hitbox]
      change_size @sizes.keys[0]
    end
    
    def change_size(key)
      return if key.to_s == @current_size 
      @rect.w = @sizes[key][:size][0]
      @rect.h = @sizes[key][:size][1]
      @current_size = key.to_s
      #make_visible
    end
    
    def w
      @rect.w
    end
    
    def h
      @rect.h
    end
    
    def top
      @rect.top
    end
    
    def bottom
      @rect.bottom
    end
    
    def right
      @rect.right
    end
      
    def left
      @rect.left  
    end
    
    def make_visible
      @image = Rubygame::Surface.new([@rect.w, @rect.h])
      @image.set_alpha 100
      @image.fill([100, 100, 100])
    end
    
    def clear_colliding_objects
      @colliding_with.clear
      @region_collisions.clear
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
      return false if @rect.nil?
      @collidable
    end
    
    def collision_detected?(hitbox)
      colliding = @rect.collide_rect? hitbox.rect
      color_rect colliding
      return colliding
    end
    
    def color_rect(colliding)
      if visible? then
        if colliding then
          @image.fill([178,34,34])
        else
          @image.fill([100, 100, 100])
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
      @rect.center = pos
    end
    
    def blit(surface, pos)
      return if not visible?
      @image.blit surface, pos #[@rect.x,@rect.y]
    end
    
    def visible?
      @image.nil? == false
    end
    
    def add_regions(regions)
      regions.each { |name,point| add_region name, point }  
    end
    
    def add_region(name, point)
      @regions[name] = point
    end
    
    def colliding_regions
      #get a list of all regions that are colliding, 
      #including who is colliding with the region
      if @region_collisions.size == 0
        @colliding_with.each do |obj|
          @regions.each do |name,r|
            x = r[0] + @rect.x
            y = r[1] + @rect.y
            if obj.hitbox.rect.collide_point? x, y then
              @region_collisions << [name, obj]
            end
          end
        end
      end
      #only do this once per frame
      return @region_collisions 
    end
    
  end
  
end