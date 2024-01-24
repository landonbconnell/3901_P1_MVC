class Card
    def initialize(num_shapes, shape, shading, color)
        @num_shapes = num_shapes
        @shape = shape
        @shading = shading
        @color = color
    end

    def num_shapes; @num_shapes; end
    def shape; @shape; end
    def shading; @shading; end
    def color; @color; end
end