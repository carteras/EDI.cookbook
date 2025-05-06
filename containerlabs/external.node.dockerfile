docker network create \
  -d bridge \
  --subnet=10.13.37.0/24 \
  --gateway=10.13.37.1 \
  --bridge=br0 \
  host-br0
