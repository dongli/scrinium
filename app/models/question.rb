class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true

  enum question_type: [
    :invalid,
    :single_line,
    :multiple_lines,
    :checkbox,
    :single_option,
    :multiple_options
  ].map { |x| I18n.t("question.question_types.#{x}") }
end
