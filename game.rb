# TODO:
#
# - Enemies
#   - Basic
#   - Moderate
#   - Boss
# - Waves (5)
# - Audio
#   - Intro
#   - Shooting sound
#   - Explosion
#   - Music
# - Title
# - Credits
# - Mobile input

DEBUG = true

# Add the path ./vendor so we can easily require third party libraries.
$: << './vendor'

require 'rok-engine/core'
require 'rok-engine/extras'

require 'lib/input'
require 'lib/tilemap'

require 'lib/wave_1'
require 'lib/wave_2'
require 'lib/wave_3'
require 'lib/wave_4'
require 'lib/wave_5'

require 'nodes/bullet'
require 'nodes/player'
require 'nodes/spawner'
require 'nodes/wall'
require 'nodes/wave'
require 'nodes/enemy/basic'

require 'scenes/defeat'
require 'scenes/game'

# Open up a window
init_window(480, 800, "Gladiators Only Love Fighting")
set_window_state(FLAG_MSAA_4X_HINT)

# Setup audio so we can play sounds
init_audio_device

# Get the current monitor frame rate and set our target framerate to match.
set_target_fps(get_monitor_refresh_rate(get_current_monitor))

$tilemap = Tilemap.new(
  image: Image.load('./assets/tilesheet.png'),
  size: 64
)

$input = Input.new({
  left: {
    keys: [KEY_A, KEY_LEFT],
    gestures: [GESTURE_SWIPE_LEFT],
    buttons: [
      { index: 0, button: GAMEPAD_BUTTON_LEFT_FACE_LEFT },
    ]
  },

  right: {
    keys: [KEY_D, KEY_RIGHT],
    gestures: [GESTURE_SWIPE_RIGHT],
    buttons: [
      { index: 0, button: GAMEPAD_BUTTON_LEFT_FACE_RIGHT },
    ]
  },
})

$scene_manager = SceneManager.new(Game.new)

map_base = File.read('./assets/map_base.csv').each_line.map { |line| line.split(',').map(&:to_i) }
map_flavour = File.read('./assets/map_flavour.csv').each_line.map { |line| line.split(',').map(&:to_i) }
map_wall_full = File.read('./assets/map_wall_full.csv').each_line.map { |line| line.split(',').map(&:to_i) }
map_wall_some = File.read('./assets/map_wall_some.csv').each_line.map { |line| line.split(',').map(&:to_i) }
map_wall_low = File.read('./assets/map_wall_low.csv').each_line.map { |line| line.split(',').map(&:to_i) }

$map_base = $tilemap.generate_from(map_base).to_texture
$map_flavour = $tilemap.generate_from(map_flavour).to_texture
$map_wall_full = $tilemap.generate_from(map_wall_full).to_texture
$map_wall_some = $tilemap.generate_from(map_wall_some).to_texture
$map_wall_low = $tilemap.generate_from(map_wall_low).to_texture

# Define your main method
def main
  # Get the amount of time passed since the last frame was rendered
  delta = get_frame_time

  # Your update logic goes here
  $scene_manager.update(delta)

  drawing do
    # Your drawing logic goes here
    clear
    $scene_manager.render

    if DEBUG
      draw_text(<<~STR, 20, 20, 20, PURPLE)
        FPS: #{get_fps}
        #{ObjectSpace.count_objects.map { |key, value| "#{key}: #{value.to_s}" }.join "\n" }
      STR
    end
  end
end

if browser?
  set_main_loop 'main'
else
  # Detect window close button or ESC key
  main until window_should_close?
end

close_audio_device
close_window
