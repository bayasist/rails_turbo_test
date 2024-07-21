class GrandChildController < ApplicationController
  def new
    @grand_child = GrandChild.new
    @child_index = params[:child_index].to_i
    @index = Time.now.to_i
  end
  def destroy
    if params[:id].to_i.zero?
      @grand_child = GrandChild.new
    else
      @grand_child = GrandChild.find(params[:id])
    end
    @index = params[:index].to_i
    @child_index = params[:child_index].to_i
  end
end
