module Theme
  FONT = Font.load('./assets/kenney_pixel.ttf', size: 24)
  PADDING = 2

  module Colour
    INITIAL    = ::Colour.new(255, 255, 255, 255)
    PRIMARY    = ::Colour.new( 77, 145, 202, 255)
    SECONDARY  = ::Colour.new( 96, 108, 118, 255)
    TERTIARY   = ::Colour.new(244, 245, 246, 255)
    QUATERNARY = ::Colour.new(209, 209, 209, 255)
    QUINARY    = ::Colour.new(225, 225, 225, 255)
  end
end
