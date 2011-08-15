require "game/core/view"
require "game/entities/text_box.rb"
require "game/entities/camera_target.rb"
require "game/entities/planet.rb"

module Game::Views

  class CameraView < Game::Core::View

    def initialize(parent)
      super parent
    end
    
    def loading
      @framerate_text = Game::Entities::TextBox.new self, [10, 10], 14
      add_entity @framerate_text
      
      player = Game::Entities::CameraTarget.new self, [300,300]
      add_entity player
      
      planet = Game::Entities::Planet.new self, [100,100], false
      add_entity planet
      
      planet2 = Game::Entities::Planet.new self, [200,200], true
      add_entity planet2
      
      marker = Game::Entities::TextBox.new self, [350,350], 10, false
      marker.text = "350,350"
      add_entity marker
      
      camera.follow player
      
    end
    
    def updating
      @framerate_text.text = "frame rate: #{clock.framerate.to_int}"
      
      
    end

    
  end

end