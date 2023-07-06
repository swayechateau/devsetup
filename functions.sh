source ./colors.sh

check_os() {
    # Check operating system
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        os="Linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        os="MacOS"
    elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" ]]; then
        os="Windows"
    else
        os="Unknown"
    fi

    echo $os
}

check_distro() {
    # Check for lsb_release command
    if command -v lsb_release > /dev/null; then
        distro=$(lsb_release -si)
    else
        # Check for /etc/os-release file
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            distro=$NAME
        else
            distro="Unknown"
        fi
    fi

    echo $distro
}

check_package_man() {
    # Check for common package managers
    if command -v apt-get > /dev/null; then
        pkg_manager="apt-get"
    elif command -v dnf > /dev/null; then
        pkg_manager="dnf"
    elif command -v yum > /dev/null; then
        pkg_manager="yum"
    elif command -v zypper > /dev/null; then
        pkg_manager="zypper"
    elif command -v pacman > /dev/null; then
        pkg_manager="pacman"
    elif command -v brew > /dev/null; then
        pkg_manager="homebrew"
    elif command -v choco > /dev/null; then
        pkg_manager="chocolatey"
    else
        return 0
    fi

    echo $pkg_manager
}

# Function to install packages using Chocolatey on Windows
install_with_choco() {
    for package in "$@"; do
        echo -e "${textgreen}Installing $package using Chocolatey...${textreset}"
        choco install -y "$package"
    done
}

# Function to install packages using Homebrew on macOS
install_with_brew() {
    for package in "$@"; do
        echo -e "${textgreen}Installing $package using Homebrew...${textreset}"
        brew install "$package"
    done
}

install_with_brew_cask() {
    for package in "$@"; do
        echo -e "${textgreen}Installing $package using Homebrew...${textreset}"
        brew install --cask "$package"
    done
}

# Function to install packages using apt-get on Ubuntu
install_with_apt() {
    for package in "$@"; do
        echo -e "${textgreen}Installing $package using apt-get...${textreset}"
        sudo apt-get install -y "$package"
    done
}

# Function to install packages using pacman on Arch Linux
install_with_pacman() {
    for package in "$@"; do
        echo -e "${textgreen}Installing $package using pacman...${textreset}"
        sudo pacman -S --noconfirm "$package"
    done
}

# Function to install packages using dnf on Fedora 22+ and RHEL 8+
install_with_dnf() {
    for package in "$@"; do
        echo -e "${textgreen}Installing $package using dnf...${textreset}"
        sudo dnf install -y "$package"
    done
}

# Function to install packages using yum on Fedora 21, RHEL 7 and below
install_with_yum() {
    for package in "$@"; do
        echo -e "${textgreen}Installing $package using yum...${textreset}"
        sudo yum install -y "$package"
    done
}

# Function to install packages using zypper on openSUSE
install_with_apt() {
    for package in "$@"; do
        echo -e "${textgreen}Installing $package using zypper...${textreset}"
        sudo zypper install -y "$package"
    done
}

get_pkg_man() {
    # Check for common package managers
    if command -v apt-get > /dev/null; then
        return "apt-get"
    elif command -v dnf > /dev/null; then
        return "dnf"
    elif command -v yum > /dev/null; then
        return "yum"
    elif command -v zypper > /dev/null; then
        return "zypper"
    elif command -v pacman > /dev/null; then
        return "pacman"
    elif command -v brew > /dev/null; then
        return "homebrew"
    elif command -v choco > /dev/null; then
        return "chocolatey"
    else
        return null
    fi
}
install_homebrew() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
}

install_package_manager() {
  # if os is windows and pkg is null then install choco
  if [[ $os == "Windows" ]]; then
    echo "No package manager detected. Installing Chocolatey."
    ./system/chocoinstall.sh
  fi
  # if os is mac and pkg is null then install brew
  if [[ $os == "macOS" ]]; then
    echo "No package manager detected. Installing Homebrew."
    install_homebrew
  fi
  # if os is linux and pkg is null then install brew
  if [[ $os == "Linux" ]]; then
    echo "No package manager detected. Installing Homebrew."
    install_homebrew
  fi
}

pkg_man_install() {
    pkg_man=$(get_pkg_man)
    for package in "$@"; do
        echo -e "${textgreen}Installing $package using $pkg_man...${textreset}"
        if [[ $pkg_man == "chocolatey" ]]; then
            install_with_choco "$program"
        elif [[ $pkg_man == "homebrew" ]]; then
            install_with_brew "$program"
        elif [[ $pkg_man == "apt-get" ]]; then
            install_with_apt "$program"
        elif [[ $pkg_man == "pacman" ]]; then
            install_with_pacman "$program"
        elif [[ $pkg_man == "dnf" ]]; then
            install_with_dnf "$program"
        elif [[ $pkg_manager == "yum" ]]; then
            install_with_yum "$program"
        elif [[ $pkg_manager == "zypper" ]]; then
            install_with_zypper "$program"
        else
            echo -e "${textred}No package manager found.${textreset}"
            exit 1
        fi
    done
}

answer_default_n() {
    for answer in "$@"; do
        if [[ $answer == "Y" || $answer == "y" ]]; then
            return 0
        fi
    done
    return 1
}

answer_default_y() {
    for answer in "$@"; do
        if answer_default_n "$answer" || [[ $answer == "" ]]; then
            return 0
        fi
    done
    return 1
}


# Function to open a URL in the default browser
open_url() {
  local url=$1
  # Check if xdg-open is available
  if command -v xdg-open >/dev/null; then
    xdg-open "$url"
  # Check if macOS open command is available
  elif command -v open >/dev/null; then
    open "$url"
  # Check if Windows start command is available through WSL
  elif command -v cmd.exe >/dev/null; then
    cmd.exe /C "start $url"
  else
    echo "Error: Unable to open URL. No supported command found."
    exit 1
  fi
}

add_nerd_font() {
    local font=$1
    brew install --cask "font-$font-nerd-font"
}