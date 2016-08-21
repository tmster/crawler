shared_context 'parser file helpers' do
  def setup_data(source)
    @source = source
  end

  def source
    @source
  end

  def fixtures_path
    @fixtures_path ||= "#{Dir.pwd}/spec/fixtures/integration/#{self.source}/"
  end

  def read_data(type, number)
    file_path = fixtures_path + "#{type}-#{number}.html"

    File.open(file_path).read
  end
end
