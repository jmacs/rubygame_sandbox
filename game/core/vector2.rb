require "./game/core/mathh"

include Game::Core::Mathh

module Game::Core
  
  class Vector2
    
    #========================================================================>
    # Start Class Methods
    #========================================================================>
    
    class << self
      
      #========================================================
      # Math Operations
      #========================================================
      
      def add(v,u)
        Vector2.add! v.copy, u
      end
      
      def add!(v,u)
        v.x = (v.x + u.x)
        v.y = (v.y + u.y)
        return v
      end
      
      def subtract(v,u)
        subtract! v.copy, u
      end
      
      def subtract!(v,u)
        v.x = v.x - u.x 
        v.y = v.y - u.y
        return v
      end
      
      def multiply(v, num)
        multiply! v.copy, num
      end
      
      def multiply!(v, num)
        v.x = v.x * num
        v.y = v.y * num
        return v
      end
      
      def divide(v, num)
        divide! v.copy, num
      end
      
      def divide!(v, num)
        if num == 0 
          v.x = 0
          v.y = 0
          return v
        end
        v.x = v.x / num if v.x != 0
        v.y = v.y / num if v.y != 0
        return v
      end
      
      def dot(v,u)
        (v.x * u.x) + (v.y * u.y)
      end
      
      #========================================================
      # Vector Attributes
      #========================================================
      
      def angle(v,u)
        Mathh.acos Vector2.normalize(v).dot(Vector2.normalize(u))
      end
      
      def distance(v,u)
        a = u.y - v.x
        b = u.y - v.y
        return Math.sqrt( (a ** 2) + (b ** 2) )
      end
      
      def direction(v)
        return -1 if v.zero?
        d = Mathh.atan2(v.y, v.x)
        return d if d > 0
        return d = 360 + d
      end
      
      def length(v)
        Math.sqrt( (v.x ** 2) + (v.y ** 2) )
      end
      
      def unit(v)
        x = v.x / v.length
        y = v.y / v.length
        return Vector2.new x, y
      end

      def unit?(v)
        v.length == 1
      end
      
      #========================================================
      # Vector Operations
      #========================================================
      
      def max(v,u)
        return v if v >= u
        return u
      end
      
      def min(v,u)
        return v if v <= u
        return u
      end
      
      def interpolate(v, u, control)
        return interpolate! v.copy, u, control
      end
      
      def interpolate!(v, u, control)
        v.x = v.x * (1-control) + u.x * control
        v.y = v.y * (1-control) + u.y * control
        return v
      end
      
      def negate(v)
        return negate! v.copy
      end
      
      def negate!(v)
        v.x = -v.x
        v.y = -v.y
        return v
      end
      
      def normalize(v)
        return normalize! v.copy
      end
      
      def normalize!(v)
        return v if v.unit?
        inverse = 1 / v.length
        v.x = v.x * inverse
        v.y = v.y * inverse
        return v
      end
      
      #========================================================
      # Misc Helper Methods
      #========================================================
      
      def one
        Vector2.new 1,1
      end
      
      def zero
        Vector2.new 0,0
      end
      
      def copy(v)
        Vector2.new v.x, v.y
      end
      
      #========================================================
      # Equality Methods
      #========================================================
      
      def equal?(v,u)
        v.x == u.x and v.y == u.y
      end
      
      def greater(v,u)
        v.length > u.length
      end
      
      def less(v,u)
        v.length < u.length
      end
      
      def greater_eql(v,u)
        v.length >= u.length
      end
      
      def less_eql(v,u)
        v.length <= u.length
      end
      
    end
    
    #========================================================================>
    # Start Instance Methods
    #========================================================================>
    
    def initialize(x,y)
      @components = [x.to_f,y.to_f]
    end
    
    #========================================================
    # X and Y
    #========================================================
    
    def x()
      @components[0]
    end
    
    def x=(value)
      @components[0] = value.to_f
    end
    
    def y()
      @components[1]
    end
    
    def y=(value)
      @components[1] = value.to_f
    end
    
    #========================================================
    # Math Operations
    #========================================================
    
    #--- add
    
    def add(other)
      Vector2.add self, other
    end
    
    def add!(other)
      Vector2.add! self, other
    end
    
    def +(other)
      Vector2.add self, other
    end
    
    def <<(other)
      Vector2.add! self, other
      return self
    end
    
    #--- subtract
    
    def subtract(other)
      Vector2.subtract self, other
    end
    
    def subtract!(other)
      Vector2.subtract! self, other
    end
    
    def -(other)
      Vector2.subtract self, other
    end
    
    #--- multiply
    
    def multiply(num)
      Vector2.multiply self, num
    end
    
    def multiply!(num)
      Vector2.multiply! self, num
    end
    
    def *(num)
      Vector2.multiply self, num
    end
    
    #--- divide
    
    def divide(num)
      Vector2.divide self, num
    end
    
    def divide!(num)
      Vector2.divide! self, num
    end
    
    def /(num)
      Vector2.divide self, num 
    end
    
    #--- dot product
    
    def dot(other)
      Vector2.dot self, other
    end
    
    #========================================================
    # Vector Attributes
    #========================================================
    
    def angle(other)
      Vector2.angle self, other
    end
    
    def distance(other)
      Vector2.distance self, other  
    end
    
    def direction
      Vector2.direction self
    end
    
    def length
      Vector2.length self
    end
    
    
    #========================================================
    # Vector Opertations
    #========================================================
    
    def negate
      Vector2.negate self
    end
    
    def negate!
      Vector2.negate! self
    end
    
    def -@()
      Vector2.negate self
    end
    
    def interpolate(other, control)
      Vector2.interpolate self, other, control
    end
    
    def interpolate!(other, control)
      Vector2.interpolate! self, other, control
    end
    
    def zero?
      self == Vector2.zero
    end
    
    def normalize
      Vector2.normalize self
    end
    
    def normalize!
      Vector2.normalize! self
    end
    
    def unit
      Vector2.unit self
    end
    
    def unit?
      Vector2.unit? self
    end
    
    def to_zero!
      self.x = 0
      self.y = 0
    end
    
    #========================================================
    # Equality Checks
    #========================================================
    
    def >(other)
      Vector2.greater self, other
    end
    
    def >=(other)
      Vector2.greater_eql self, other
    end
    
    def <(other)
      Vector2.less self, other
    end
    
    def <=(other)
      Vector2.less_eql self, other
    end
    
    def ==(other)
      return false unless Vector2 === other
      Vector2.equal? self, other
    end
    
    def eql?(other)
      return false unless Vector2 === other
      Vector2.equal? self, other
    end
    
    #========================================================
    # Misc Class Operations
    #========================================================
    
    def to_s
      "[#{x},#{y}]"
    end
    
    def to_s_formated
      sx = "%0.2f" % self.x
      sy = "%0.2f" % self.y
      "[#{sx},#{sy}]"
    end
    
    def to_a
      @components
    end
    
    def copy
      Vector2.copy self
    end
    
    def clone(other)
      self.x = other.x
      self.y = other.y
    end
    
  end

end