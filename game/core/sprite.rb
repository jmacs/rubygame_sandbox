require "./game/core/entity.rb"
require "./game/core/collision_hitbox.rb"
require "./game/core/script_manager.rb"
require "./game/core/animation.rb"

module Game::Core

  class Sprite < Game::Core::Entity
    
    attr_reader :hitbox
    attr_reader :animation
    
    def initialize(view, pos)
      super view, pos
      @animation = Animation.new
      @hitbox = CollisionHitbox.new
    end
    
    def load_script(script_name)
      script = ScriptManager.actors[script_name]
      @animation.load script
      @hitbox.load script
    end
    
    def update
      super
    end
    
    def adjust
      super
      @animation.animate
      @hitbox.update @spos
    end
    
    def draw
      super
      cblit @hitbox
      cblit @animation
    end

    def change_animation(name)
      @animation.change name
      @hitbox.change @animation.hitbox
    end
    
    def set_animation_speed(speed)
      @animation.set_speed speed
    end
    
  end

end