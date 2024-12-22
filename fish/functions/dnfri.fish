function dnfri --wraps='sudo dnf reinstall' --description 'alias dnfri=sudo dnf reinstall'
  sudo dnf reinstall $argv
        
end
