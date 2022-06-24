module Theme
  FONT = Font.load('./assets/kenney_pixel.ttf', size: 24)
  PADDING = 2

  module Colour
    INITIAL    = ::Colour.new(255, 255, 255, 255)
    PRIMARY    = ::Colour.new(192, 65,  111, 255)
    SECONDARY  = ::Colour.new(254, 247, 204, 255)
    TERTIARY   = ::Colour.new(245, 125, 129, 255)
    QUATERNARY = ::Colour.new(209, 209, 209, 255)
    QUINARY    = ::Colour.new(225, 225, 225, 255)
  end
end
