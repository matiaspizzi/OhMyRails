class TimelinessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    unless value.is_a?(Date) || value.is_a?(Time)
      record.errors.add(attribute, "must be a valid time or date")
    end
  end
end
