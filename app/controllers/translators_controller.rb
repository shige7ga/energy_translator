class TranslatorsController < ApplicationController
  def index
  end

  def create
    running_time = RunningTimeTranslator.call(params[:kcal])
    @output = "約#{running_time}分の軽いランニング"

    render partial: "translators/shared/result"
  end
end
