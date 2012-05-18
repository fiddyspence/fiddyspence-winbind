Facter.add(:winbind_enabled) do
  confine :kernel => :linux
  setcode do
    winbind_enabled = Facter::Util::Resolution.exec('wbinfo -t 2> /dev/null')
    if winbind_enabled =~ /succeeded/
      "true"
    else
      "false"
    end
  end
end
