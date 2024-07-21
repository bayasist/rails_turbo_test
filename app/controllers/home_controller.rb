class HomeController < ApplicationController
  def new
  end
  def index
    @parents = Parent.all
  end
  def show
    @parent = Parent.find(params[:id])
  end
  def edit
    @parent = Parent.find(params[:id])
  end
  def update
    @parent = Parent.find(params[:id])
    children = parent_edit_params["children_attributes"].to_h.values
    deleting_children = children.select { |grand_child| grand_child["delete_flag"] == "true" }
    grand_children = children.map { |child| child["grand_children_attributes"].to_h.values }.flatten
    deleting_grand_children = grand_children.select { |grand_child| grand_child["delete_flag"] == "true" }
    update_parent = parent_edit_params.to_h
    update_parent["children_attributes"] = update_parent["children_attributes"].reject { |_, child| child["delete_flag"] == "true" }
    update_parent["children_attributes"].each do |key, child|
      next if child["grand_children_attributes"].nil?
      update_parent["children_attributes"][key]["grand_children_attributes"] = child["grand_children_attributes"].reject { |_, grand_child| grand_child["delete_flag"] == "true" }
    end
    ActiveRecord::Base.transaction do
      GrandChild.where(id: deleting_grand_children.map { |grand_child| grand_child["id"] }).destroy_all
      Child.where(id: deleting_children.map { |child| child["id"] }).destroy_all
      @parent.update!(update_parent)
    end
    redirect_to home_index_path, status: 303
  end
  def create
    parent = Parent.new(parent_params)
    parent.save!
    redirect_to home_index_path, status: 303
  end
  private
  def parent_params
    params.require(:parent).permit(:name, children_attributes: [:id, :name, grand_children_attributes: [:id, :name]])
  end
  def parent_edit_params
    params.require(:parent).permit(:name, children_attributes: [:id, :name, :delete_flag, grand_children_attributes: [:id, :name, :delete_flag]])
  end
end
