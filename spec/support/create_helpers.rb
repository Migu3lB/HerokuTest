module RSpec::CreateHelpers

  def stub_user
    allow_any_instance_of(User).to receive(:send_email).and_return(nil)
  end

end