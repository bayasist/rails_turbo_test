class ChildController < ApplicationController
  def new
    @child = Child.new
    @index = Time.now.to_i
  end

  def destroy
    if params[:id].to_i.zero?
      @child = Child.new
    else
      @child = Child.find(params[:id])
    end
    @index = params[:index].to_i
  end
end
