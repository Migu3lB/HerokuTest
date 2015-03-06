class Product < ActiveRecord::Base
	# Validaciones para las columnas que conforman la clase Product
	validates :ref, :price, :quantity, :brand, :name, :description, :size, :color, presence: true
	validates :size, length: {in: 1..3}
	validates :price, numericality: {greater_than: 0}
	validates :ref, uniqueness: true

	# Un producto tiene varios items de linea (Puede interpretarse como que un usuario tiene varios items en una factura)
	has_many :line_items
end
