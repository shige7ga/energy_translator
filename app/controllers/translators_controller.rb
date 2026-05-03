class TranslatorsController < ApplicationController
  def index
    @conversions = Conversion.all
  end

  def create
    @input = params[:input].to_f
    @conversion = Conversion.find(params[:conversion_id])
    @output = @conversion.translate(@input)

    render partial: "translators/shared/result"
  end
end
