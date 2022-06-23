class SoundManager
  attr_reader :background_music, :sounds

  def initialize
    @background_tracks = {
      main: Music.load('./assets/airtone_spacedust_1.ogg'),
    }

    @sounds = {
      defeat: Sound.load('./assets/defeat.wav'),
      explosion: Sound.load('./assets/explosion.wav'),
      hurt: Sound.load('./assets/hurt.wav'),
      shoot: Sound.load('./assets/shoot.wav'),
    }

    @sounds.values.each { _1.volume = 0.5 }

    @background_music = @background_tracks[:main]
  end

  def switch_background_music_to(value)
    @background_music = @background_tracks[value]
  end

  def tick(delta)
    @background_music.update
  end

  def play(sound)
    @sounds[sound].pitch = 0.75 + (rand * 0.5)
    @sounds[sound].volume = 0.3 + (rand * 0.15)
    # TODO: Pitch doesn't work without multi: false ????
    @sounds[sound].play(multi: false)
  end

  def draw
  end
end
