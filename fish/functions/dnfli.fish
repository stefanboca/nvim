function dnfli --wraps='dnf list --installed' --description 'alias dnfli=dnf list --installed'
  dnf list --installed $argv
        
end
