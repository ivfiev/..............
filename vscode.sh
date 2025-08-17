export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_ROOT=$HOME/dothate/dotnet-sdk-9.0.300-linux-x64
export PATH=$PATH:$PATH/go/bin:$HOME/dothate/dotnet-sdk-9.0.300-linux-x64

/usr/bin/code --enable-features=UseOzonePlatform --ozone-platform=wayland "$@"
