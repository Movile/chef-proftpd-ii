describe port(21) do
  it { should be_listening }
  its('processes') { should include 'proftpd' }
end

describe service('proftpd') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe port(2222) do
  it { should be_listening }
  its('processes') { should include 'proftpd' }
end
