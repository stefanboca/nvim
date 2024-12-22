function dnfsw --wraps='sudo dnf swap' --description 'alias dnfsw=sudo dnf swap'
  sudo dnf swap $argv
        
end
