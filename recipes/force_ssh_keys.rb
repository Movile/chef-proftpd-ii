
# Enforce 0400 permission on host key files, required by ProFTPd
node['proftpd-ii']['sftp_hostkeys'].each do |key|
  file key do
    mode 0o400
  end
end
