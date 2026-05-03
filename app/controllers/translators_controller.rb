class TranslatorsController < ApplicationController
  def index
  end

  def create
    @conversion = Conversion.find(1)
    running_time = @conversion.translate(params[:kcal].to_f)
    @output = "約#{running_time}分の軽いランニング"

    render partial: "translators/shared/result"
  end
end
