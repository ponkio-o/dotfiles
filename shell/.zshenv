# https://qiita.com/uasi/items/80865646607b966aedc8
PATH=${NVM_DIR:-$HOME/.nvm}/default/bin:$PATH
MANPATH=${NVM_DIR:-$HOME/.nvm}/default/share/man:$MANPATH
export NODE_PATH=${NVM_DIR:-$HOME/.nvm}/default/lib/node_modules
NODE_PATH=${NODE_PATH:A}
