try_install() {
    name=$1
    install=$2
    deps=$3
    exists=$4

    GREEN='\033[32m'
    YELLOW='\033[33m'
    RED='\033[31m'
    NC='\033[00m'

    if exists; then
        echo -e "${YELLOW}${name} already installed${NC}"
    elif ! deps; then
        echo -e "${RED}${name} lacks dependencies${NC}"
        return 1
    else
        echo -e "${GREEN}Installing ${name}...${NC}"
        set +e
        ( set -e; install )
        test $? -ne 0 && echo -e "${RED}Installation failed${NC}" && return 1
        set -e
        echo -e "${GREEN}${name} installed${NC}"
    fi
}
