module ApiError

  Unauthorized = Class.new(StandardError)
  Base = Class.new(StandardError)

  CODE = {
      Unauthorized: 401
  }

  def self.raise_error(error_class_name, error_msg = nil)
    error_class = const_get(error_class_name)
    raise error_class, error_msg
  end

  def self.get_code(error)
    CODE[error.class]
  end

end