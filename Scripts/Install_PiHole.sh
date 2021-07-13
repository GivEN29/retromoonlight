#!/bin/bash
# set -euo pipefail

echo -e "Installing PiHole..."
curl -sSL https://install.pi-hole.net | bash

echo -e "Do not forget to set the blocklist for PiHole!"
echo -e "This list is a good starting point:"
echo -e "  - https://firebog.net/"
