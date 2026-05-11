# AGENTS.md

## Cursor Cloud specific instructions

### Overview

This is a Python Flask HTTPS tile server that downloads USGS 3DEP LiDAR point cloud data from AWS S3, processes it into Digital Surface Models (DSM), and serves map tiles as PNGs. It uses PDAL for point cloud processing, which requires native C++ libraries.

### Environment

- **Conda environment**: `lidar` (installed via Miniforge at `~/miniforge3`)
- **Activation**: `export PATH="$HOME/miniforge3/bin:$PATH" && eval "$(conda shell.bash hook)" && conda activate lidar`
- PDAL *must* be installed via conda (not pip) because it requires native C++ libraries (`libpdal`).
- `pyOpenSSL` is required for `generate_cert.py` but is not listed in `requirements.txt`.

### Running the server

1. Generate SSL certs if they don't exist: `python generate_cert.py` (creates `cert.pem` and `key.pem`)
2. Start the server: `python lidar_dsm_tile_server.py` (HTTPS on port 5000)
3. On first run without a cache, the server downloads ~50MB of GeoJSON boundary data from GitHub and caches it as `3dep_dataset_cache.pkl`.

### Testing

- There are no automated tests in this repository.
- There is no linter configuration.
- Manual testing: `curl -k https://localhost:5000/tiles/idw/18/74975/100281.png -o tile.png` (requests a DC-area LiDAR tile; takes a few seconds on first fetch due to AWS point cloud download).
- Only zoom level 18 is supported; other zoom levels return HTTP 400.
- Tiles for areas without LiDAR coverage return HTTP 404.

### Key gotchas

- The server requires `cert.pem` and `key.pem` in the working directory. These are gitignored and must be regenerated each session.
- Tile requests that fetch new point cloud data from AWS can take 5-30+ seconds depending on point density and network speed.
- The server creates `tiles/`, `dsms/`, and `pointclouds/` directories with method subdirectories (`min`, `max`, `mean`, `idw`) on startup.
