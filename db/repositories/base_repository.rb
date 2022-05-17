Struct.new('Result', :status, :values)

class BaseRepository
  def result(status_success, status_error)
    unless validate_status!(status_success) && validate_status!(status_error)
      raise ArgumentError, 'Status NOT an Integer!'
    end

    begin
      Struct::Result.new(status_success, yield)
    rescue StandardError => e
      Struct::Result.new(status_error, nil)
    end
  end

  private

  def validate_status!(status)
    Integer(status) && status >= 100
  end
end
