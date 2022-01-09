try_install() {
    name=$1
    install=$2
    deps=$3
    exists=$4

    # TODO: make the messages stand out
    #GREEN='\033[0;32m'
    #GREY='\033[0;37m'
    #RED='\033[0;31m'
    #NC='\033[0m'

    if exists; then
        #echo "${GREY}${name} already installed${NC}"
        echo "${name} is already installed"
    elif ! deps; then
        #echo "${RED}${name} lacks dependencies${NC}"
        echo "${name} lacks dependencies"
        return 1
    else
        #echo "${GREEN}Installing ${name}...${NC}"
        echo "Installing ${name}..."
        install
        #echo -e "${GREEN}${name} installed${NC}"
        echo -e "${name} was installed"
    fi
}
