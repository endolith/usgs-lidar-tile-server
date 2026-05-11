#!/usr/bin/env bash
# Remove PDAL DRACO reader/writer plugins from a conda/mamba environment.
#
# Conda-forge PDAL often installs libpdal_plugin_*_draco.* even when libdraco
# is not a dependency; PDAL still tries to load them and logs errors (see
# GitHub issue #38). This tile server only needs EPT/LAS/GDAL-related stages.
#
# Deleting these shaves a little image size and avoids noisy startup logs.
# Call from a Dockerfile after installing PDAL, for example:
#   COPY scripts/remove-pdal-draco-plugins.sh /tmp/
#   RUN chmod +x /tmp/remove-pdal-draco-plugins.sh \
#       && CONDA_PREFIX=/opt/conda /tmp/remove-pdal-draco-plugins.sh
#
# Usage: CONDA_PREFIX=/path/to/env ./remove-pdal-draco-plugins.sh
#    or: ./remove-pdal-draco-plugins.sh /path/to/env

set -euo pipefail

prefix="${1:-${CONDA_PREFIX:-}}"
if [[ -z "${prefix}" ]]; then
  echo "Set CONDA_PREFIX or pass the env root as the first argument." >&2
  exit 1
fi

shopt -s nullglob
removed=0
for libdir in "${prefix}/lib" "${prefix}/lib/pdal"; do
  [[ -d "${libdir}" ]] || continue
  for f in "${libdir}"/libpdal_plugin_*draco*.so "${libdir}"/libpdal_plugin_*draco*.dylib; do
    rm -f "${f}"
    removed=$((removed + 1))
  done
done

if [[ "${removed}" -eq 0 ]]; then
  echo "No PDAL DRACO plugin libraries found under ${prefix}/lib (nothing to remove)." >&2
fi
