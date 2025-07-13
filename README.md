# usgs-lidar-tile-server

Python-based slippy map tile server that downloads and processes USGS 3DEP LIDAR point clouds into DEMs (DSM) and generates tiles. Intended to reveal hidden terrain features (building edges, cliffs) under vegetation in OpenStreetMap iD Editor

## Attribution

This project is based on the [OpenTopography 3DEP Workflows repository](https://github.com/OpenTopography/OT_3DEP_Workflows).

- Speed, C., Beckley, M., [Crosby, C.](https://orcid.org/0000-0003-2522-4193), & [Nandigam, V.](https://orcid.org/0000-0003-0928-9851) (2022). Reproducible scientific workflows for accessing, processing, and visualizing USGS 3DEP lidar data (Version 1.0.0) [Computer software]. <https://github.com/opentopography/OT_3DEP_Workflows>

The `01_3dep_generate_dem_user_aoi.py` file was saved from the Jupyter notebook [`01_3DEP_Generate_DEM_User_AOI.ipynb`](https://github.com/OpenTopography/OT_3DEP_Workflows/blob/main/notebooks/01_3DEP_Generate_DEM_User_AOI.ipynb) from the original repository (commit 8f2d9bfa91fd582d95bdb30daa5ffbe460900782).

## License

This project is derived from the above notebook and is therefore also licensed under the GPLv3.  See [LICENSE.txt](LICENSE.txt).
