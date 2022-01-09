try_install() {
    name=$1
    install=$2
    deps=$3
    exists=$4

    # TODO: make the messages stand out
    #GREEN='\033[0;32m'
    #GREY='\033[0;37m'
    #NC='\033[0m'

    if deps && ! exists; then
        #echo "${GREEN}Installing ${name}...${NC}"
        echo "Installing ${name}..."
        install
        #echo -e "${GREEN}${name} installed${NC}"
        echo -e "${name} installed"
    else
        #echo "${GREY}${name} already installed${NC}"
        echo "${name} already installed"
    fi
}
