class AcceptablesController < ApplicationController
  before_action :set_acceptable, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @acceptables = Acceptable.all
    respond_with(@acceptables)
  end

  def show
    respond_with(@acceptable)
  end

  def new
    @acceptable = Acceptable.new
    respond_with(@acceptable)
  end

  def edit
  end

  def create
    @acceptable = Acceptable.new(acceptable_params)
    @acceptable.save
    respond_with(@acceptable)
  end

  def update
    @acceptable.update(acceptable_params)
    respond_with(@acceptable)
  end

  def destroy
    @acceptable.destroy
    respond_with(@acceptable)
  end

  private
    def set_acceptable
      @acceptable = Acceptable.find(params[:id])
    end

    def acceptable_params
      params.require(:acceptable).permit(:type, :text, :version)
    end
end
