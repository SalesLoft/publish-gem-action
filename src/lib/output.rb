module Output
  def self.error(msg)
    $stderr.puts("::error::#{msg}")
  end
end
