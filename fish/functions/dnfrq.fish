function dnfrq --wraps='dnf repoquery' --description 'alias dnfrq=dnf repoquery'
  dnf repoquery $argv
        
end
