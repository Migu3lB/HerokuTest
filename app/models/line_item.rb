class LineItem < ActiveRecord::Base
	# Valida que quantity sea un numero entero
	validates :quantity, numericality: {greater_than: 0}
	# Validacion Personalizada
	validate :validate_stock
	# Pertenece a product y a sell
	belongs_to :product
	belongs_to :sell
	# antes de crear llama al metodo init_value
	before_create :init_value
	# despues de crear actualiza la cantidad de inventario disponible
	after_create :update_stock
	# despues de borrar devuelve el valor al stock de los productos
	after_destroy :add_stock

	def init_value
		self.value = self.quantity * self.product.price 
	end

	def update_stock
		self.product.update_attribute(:quantity, self.product.quantity - self.quantity)
	end

	def validate_stock
		if self.quantity > self.product.quantity
			errors.add(:quantity, "No hay suficientes productos en stock")
		end	
	end	

	def add_stock
		self.product.update_attribute(:quantity, self.product.quantity + self.quantity)
	end

end
