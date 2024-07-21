class Parent < ApplicationRecord
  has_many :children, dependent: :destroy
  accepts_nested_attributes_for :children, allow_destroy: true
end
