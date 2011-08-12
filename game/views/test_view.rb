require "game/core/view"
require "game/core/collision_node"
require "game/core/collision_tree"
require "game/entities/text_box.rb"
require "game/core/world_map.rb"
require "game/core/log.rb"
require "game/entities/fox.rb"
require "game/entities/planet.rb"

module Game::Views

  class TestView < Game::Core::View

    def initialize(parent)
      super parent
    end
    
    def load
      parent_collision_node = Game::Core::CollisionNode.new Rubygame::Rect.new(0, 0, 640, 480), 5
      @collision_tree = Game::Core::CollisionTree.new parent_collision_node

      @framerate_text = Game::Entities::TextBox.new self, [10, 10], 14
      add_entity @framerate_text
      
      @world = Game::Core::WorldMap.new
      
      @input = Game::Core::PlayerInput    
      
      player = Game::Entities::Fox.new self, [320,240]
      add_entity player
      @collision_tree.objects << player
      
      planet1 = Game::Entities::Planet.new self, [100,100]
      add_entity planet1
      @collision_tree.objects << planet1

      planet2 = Game::Entities::Planet.new self, [2000,200]
      add_entity planet2
      @collision_tree.objects << planet2

      planet3 = Game::Entities::Planet.new self, [100,100], false
      add_entity planet3
      @collision_tree.objects << planet3

      marker = Game::Entities::TextBox.new self, [300, 300], 14
      add_entity marker
      
      @camera.follow player
      
    end
    
    def update
      @framerate_text.text = "frame rate: #{clock.framerate.to_int}"
      @collision_tree.update
      @entities.each { |id,e| e.update }
    end

    def draw
      
      #retrieve the center point where the camera would be over on the map
      camera = @camera.pos

      @world.draw surface, camera[0], camera[1]
      
      @entities.each { |id,e| e.draw }
    end
    
  end

end