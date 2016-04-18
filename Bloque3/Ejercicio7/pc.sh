#!/bin/bash

export OMP_SCHEDULE="static"
echo "static y chunk por defecto"
./pmtvomp 4096

export OMP_SCHEDULE="static,2"
echo "static y chunk 2"
./pmtvomp 4096

export OMP_SCHEDULE="static,32"
echo "static y chunk 32"
./pmtvomp 4096

export OMP_SCHEDULE="static,64"
echo "static y chunk 64"
./pmtvomp 4096

export OMP_SCHEDULE="static,1024"
echo "static y chunk 1024"
./pmtvomp 4096

export OMP_SCHEDULE="dynamic"
echo "dynamic y chunk por defecto"
./pmtvomp 4096

export OMP_SCHEDULE="dynamic,2"
echo "dynamic y chunk 2"
./pmtvomp 4096

export OMP_SCHEDULE="dynamic,32"
echo "dynamic y chunk 32"
./pmtvomp 4096

export OMP_SCHEDULE="dynamic,64"
echo "dynamic y chunk 64"
./pmtvomp 4096

export OMP_SCHEDULE="dynamic,1024"
echo "dynamic y chunk 1024"
./pmtvomp 4096

export OMP_SCHEDULE="guided"
echo "guided y chunk por defecto"
./pmtvomp 4096

export OMP_SCHEDULE="guided,2"
echo "guided y chunk 2"
./pmtvomp 4096

export OMP_SCHEDULE="guided,32"
echo "guided y chunk 32"
./pmtvomp 4096

export OMP_SCHEDULE="guided,64"
echo "guided y chunk 64"
./pmtvomp 4096

export OMP_SCHEDULE="guided,1024"
echo "guided y chunk 1024"
./pmtvomp 4096
