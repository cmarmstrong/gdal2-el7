#!/bin/bash
VERSION="2.3.1"

tar xvf gdal-"${VERSION}".tar.xz

mv gdal-"${VERSION}"{,-fedora} && pushd gdal-"${VERSION}"-fedora

rm data/cubewerx_extra.wkt
rm data/esri_extra.wkt
rm data/esri_Wisconsin_extra.wkt
rm data/esri_StatePlane_extra.wkt
rm data/ecw_cs.wkt

#Really necessary?
rm -r swig/php

popd


#TODO: Insert Provenance file

tar cvfJ gdal-"${VERSION}"-fedora.tar.xz gdal-"${VERSION}"-fedora
