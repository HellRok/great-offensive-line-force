class Input
  def initialize(keys)
    @keys = keys
    setup_meta_methods
  end

  private
  def down?(input)
    keyboard_down?(@keys[input].fetch(:keys, [])) ||
      button_down?(@keys[input].fetch(:buttons, []))
  end

  def up?(input)
    keyboard_up?(@keys[input].fetch(:keys, [])) ||
      button_up?(@keys[input].fetch(:buttons, []))
  end

  def pressed?(input)
    keyboard_pressed?(@keys[input].fetch(:keys, [])) ||
      gestured?(@keys[input].fetch(:gestures, [])) ||
      button_pressed?(@keys[input].fetch(:buttons, []))
  end

  def released?(input)
    keyboard_released?(@keys[input].fetch(:keys, [])) ||
      button_released?(@keys[input].fetch(:buttons, []))
  end

  def keyboard_down?(keys)
    keys.any? { key_down? _1 }
  end

  def keyboard_up?(keys)
    keys.any? { key_up? _1 }
  end

  def keyboard_pressed?(keys)
    keys.any? { key_pressed? _1 }
  end

  def keyboard_released?(keys)
    keys.any? { key_released? _1 }
  end

  def button_down?(buttons)
    buttons.any? { gamepad_button_down? _1[:index], _1[:button] }
  end

  def button_up?(buttons)
    buttons.any? { gamepad_button_up? _1[:index], _1[:button] }
  end

  def button_pressed?(buttons)
    buttons.any? { gamepad_button_pressed? _1[:index], _1[:button] }
  end

  def button_released?(buttons)
    buttons.any? { gamepad_button_released? _1[:index], _1[:button] }
  end

  def gestured?(gestures)
    gestures.include? get_gesture_detected
  end

  def setup_meta_methods
    @keys.keys.each { |key|
      self.class.define_method "#{key}_down?"     do; down? key;     end
      self.class.define_method "#{key}_up?"       do; up? key;       end
      self.class.define_method "#{key}_pressed?"  do; pressed? key;  end
      self.class.define_method "#{key}_released?" do; released? key; end
    }
  end
end
