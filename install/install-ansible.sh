apt install -y pipx
pipx install --include-deps ansible
pipx ensurepath
pipx inject ansible requests


