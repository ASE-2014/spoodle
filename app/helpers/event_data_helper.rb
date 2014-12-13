module EventDataHelper

  def attribute_label(attribute_name)
    attribute_name.to_s.capitalize.gsub('_', ' ')
  end

  def units_label(units)
    unless units.empty?
      return "(#{units})"
    end
    ''
  end
end