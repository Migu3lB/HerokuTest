class Sell < ActiveRecord::Base
	# Validaciones
	validates :total, numericality: {greater_or_equal_than: 0}
	validates :comment, :total, presence: {message: "Pilas!! no puede estar vacio!!!"}

	# Una venta tiene varias items de linea. Y cada que se agrega un item de linea a la venta se suman las cantidades
	# y depues de borrar un item de linea se descuenta un item del valor total 
	has_many :line_items, after_add: :add_item, after_remove: :remove_item
	belongs_to :user

	def add_item(line_item)
		if line_item.valid?
			self.update_attribute(:total, 
				self.total + line_item.value)
		end
	end

	def remove_item(line_item)
		if line_item.valid?
			self.update_attribute(:total, 
				self.total - line_item.value)
		end
	end

end