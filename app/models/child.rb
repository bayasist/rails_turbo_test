class Child < ApplicationRecord
  belongs_to :parent
  has_many :grand_children, dependent: :destroy
  accepts_nested_attributes_for :grand_children, allow_destroy: true
end
