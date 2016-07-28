shared_context 'parser file helpers' do
  def fixtures_path
    @fixtures_path ||= "#{Dir.pwd}/spec/fixtures/integration/gratka/"
  end

  def read_data(type, number)
    file_path = fixtures_path + "#{type}-#{number}.html"

    File.open(file_path).read
  end
end
