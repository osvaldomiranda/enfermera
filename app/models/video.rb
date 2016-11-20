class Video < ActiveRecord::Base

  def vid
  	if alojamiento.index('=').present?
    	self.alojamiento[alojamiento.index('=')+1..50]
    else
    	# errors.add(:alojamiento, 'No se pudo crear Colegiada') 	
    end	
  end
end
