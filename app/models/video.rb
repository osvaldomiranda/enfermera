class Video < ActiveRecord::Base

  def vid
    self.alojamiento[alojamiento.index('=')+1..50]
  end
end
