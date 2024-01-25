class Card
    attr_accessor :num_shapes, :shape, :shading, :color

    def initialize(num_shapes, shape, shading, color)
        @num_shapes = num_shapes
        @shape = shape
        @shading = shading
        @color = color
    end
end