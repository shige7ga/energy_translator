class TranslatorsController < ApplicationController
  def index
    @form = TranslationForm.new
    @conversions = Conversion.all
  end

  def create
    @form = TranslationForm.new(translation_params)

    if @form.valid?
      output = @form.result_for_display

      render turbo_stream: [
        turbo_stream.update("input_error", ""),
        turbo_stream.update("conversion_id", ""),
        turbo_stream.update(
          "result_area",
          partial: "translators/shared/result",
          locals: { output: output }
        )
      ]
    else
      render turbo_stream: [
        turbo_stream.update(
          "input_error",
          partial: "translators/shared/field_error",
          locals: { form: @form, field: :input }
        ),
        turbo_stream.update(
          "conversion_id_error",
          partial: "translators/shared/field_error",
          locals: { form: @form, field: :conversion_id }
        ),
        turbo_stream.update("result_area", "")
      ], status: :unprocessable_entity
    end
  end

  private

  def translation_params
    params.require(:translation_form).permit(:input, :conversion_id)
  end
end
