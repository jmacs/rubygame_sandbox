
module Game::Core

  class Layer


    attr_reader :tile_width
    attr_reader :tile_height
    attr_reader :name
    attr_reader :entity_id

    attr_accessor :layer_no
    attr_accessor :visible

    def initialize (area,tiles,tile_width,tile_height)
      @name = tiles
      @entity_id = GOID.next

      @tile_width = tile_width
      @tile_height = tile_height

      @visible = true
      @tiles = Rubygame::Surface.load "./resource/img/#{tiles}.png"
      @rect_tile = Rubygame::Rect.new 0, 0, @tile_width, @tile_height

      if (!area.nil?) then
        @area = eval File.open("./resource/area/#{area}.area").read
       else
         @area = [[0]]
       end

      @layer_no = 0

      @speed = [150,150]

      @pos = [0,0]

      @last_camera = [0,0]

      # what are the dimensions of the map loaded
      @world_width = @area[0].length
      @world_height = @area.length

      @screen_tiles_height = 0
      @screen_tiles_width = 0

      @desired_tiles_width = nil
      @desired_tiles_height = nil
    end

    def make_parallax (tiles_width_amount,tiles_height_amount,speed, pos = nil)
       @desired_tiles_width = tiles_width_amount
       @desired_tiles_height = tiles_height_amount
       
       @speed = speed
       @manual_set = true
       if pos.nil? == false
         @pos = pos
       end
    end

    def setup_blit(background)
      temp_width_amount = amount_of_tiles @tile_width,background.width
      temp_height_amount = amount_of_tiles @tile_height, background.height

      if @desired_tiles_width.nil? == true || @desired_tiles_width > temp_width_amount
        @screen_tiles_width = temp_width_amount
      else
        @screen_tiles_width = @desired_tiles_width
      end

      if @desired_tiles_height.nil? == true || @desired_tiles_height > temp_height_amount
        @screen_tiles_height =  temp_height_amount
      else
        @screen_tiles_height = @desired_tiles_height
      end

    end

    def amount_of_tiles (increase_by,till)
      #calculates the amount of times a value
      a = 0 - increase_by/4
      need = 0
      while  a < (till + increase_by )
        need += 1
        a += increase_by
      end

      return need
    end

    def update(clock,camera_pos,background)
      handle_displacement clock,camera_pos


      @pos[0] = start_blit_pos @pos[0],@tile_width
      if @manual_set.nil? == true
         @pos[1] = start_blit_pos @pos[1],@tile_height
         #puts "name:#{@name} pos y #{@pos[1]}"
      end

      blit_layer camera_pos,background

      @last_camera = [camera_pos[0],camera_pos[1]]
    end


    def handle_displacement clock,camera_pos
      @displacement_x = 0
      @displacement_y = 0

      if @last_camera[0] < camera_pos[0] #moving forward
        @displacement_x = (@speed[0] * clock.seconds)
      elsif @last_camera[0] > camera_pos[0] #moving backward
        @displacement_x = (@speed[0] * clock.seconds) * -1
      end
      @pos[0] -= @displacement_x

      if @last_camera[1] < camera_pos[1] #moving up
        @displacement_y = (@speed[1] * clock.seconds)
      elsif @last_camera[1] > camera_pos[1] #moving down
        @displacement_y = (@speed[1] * clock.seconds) * -1
      end
      @pos[1] -= @displacement_y

    end


    def blit_layer(camera_pos,background)
      #Algorithmn at  http://www.cpp-home.com/tutorials/292_1.htm

      #Create the Screen from left to right, top to bottom
      y, x = 0, 0

      @screen_tiles_height.to_int.times do

        @screen_tiles_width.to_int.times do

             map_pos = [x + (camera_pos[0] / @tile_width),y + (camera_pos[1] / @tile_height)]

             #Use Bitwise AND to get finer offset
             #If you remove the -1 you get tile by tile moving as the offset is always 0,0
             offset_x = (x * @tile_width) -  (camera_pos[0].to_i & (@tile_width - 1) )
             offset_y = (y * @tile_height) - (camera_pos[1].to_i & (@tile_height - 1))

             tile_num = get_tile map_pos
             get_blit_rect tile_num,@rect_tile

             @tiles.blit background, [offset_x,offset_y], @rect_tile

            x = x + 1
        end
        x = 0
        y = y + 1
      end

    end

    def get_tile(map_pos)
        #this section creates the effect of an infinite world (aka xy treadmill like scrolling)
         if map_pos[0] < -@world_width then
           map_pos[0] = -@world_width + (map_pos[0] % @world_width)
         end

         if map_pos[0] >= @world_width then
           map_pos[0] = (map_pos[0] % @world_width)
         end


         if map_pos[1] <= -@world_height then
           map_pos[1] = -@world_height + (map_pos[1] % @world_height)
         end

         if map_pos[1] >= @world_height then
           map_pos[1] = (map_pos[1] % @world_height)
         end

       begin
        #you swap them otherwise the map is flipped 90 degrees counter clockwise
        tile_no = @area[map_pos[1]][map_pos[0]]
      rescue
        puts "get_tile - rescued xy #{map_pos[1]},#{map_pos[0]}"
        tile_no = 0
      end

      if tile_no.nil? then
        puts "get_tile - tile_no nill xy #{map_pos[1]},#{map_pos[0]}"
        return 0
      end

      return tile_no
    end

    def get_blit_rect(tile_no, rect)
        #TODO: properly clip tile for efficiency
        rect.left = 0
        rect.right = @tile_width
        rect.top = tile_no * @tile_height
        rect.bottom = rect.top + @tile_height
    end

    def start_blit_pos (pos,amount)
      return 0 if pos.abs >= amount

      start = pos
      while (start > 0)
        start -= amount
      end
      return start
    end


  end

end