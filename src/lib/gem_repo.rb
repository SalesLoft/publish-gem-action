class GemRepo
  UploadFailed = Class.new(StandardError)
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def upload(gem)
    io = IO.popen(%{curl -sS --fail --form "file=@#{gem}" #{url}})
    Process.wait(io.pid)
    result = io.read

    if $?.success? && successful?(result)
      puts result
      true
    else
      raise UploadFailed.new(result)
    end
  end

  private

  def successful?(result)
    result =~ /received and indexed./
  end
end
