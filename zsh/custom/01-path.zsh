# rust cargo
test -f "$HOME/.cargo/env" && source "$HOME/.cargo/env"

# golang
export GOPATH="$HOME/.local/share/go"
if [[ -d "$GOPATH" ]] then
  PATH="$PATH:$GOPATH/bin"
fi

# pixi
export PIXI_HOME="$HOME/.local/share/pixi"
if [[ -d "$PIXI_HOME" ]] then
  PATH="$PIXI_HOME/bin:$PATH"
fi


# spicetify
if [[ -d "$HOME/.local/share/spicetify" ]] then
  PATH="$PATH:$HOME/.local/share/spicetify"
fi

# gradle
if [[ -d "/opt/gradle/gradle-8.2.1" ]] then
  PATH="$PATH:/opt/gradle/gradle-8.2.1/bin"
fi

export PATH
