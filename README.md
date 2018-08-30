# neuroglia-core

Singularity image for neuroimaging dependencies. Base image for khanlab apps and containers. Includes:

* Neurodebian
* Octave
* Nipype
* FSL
* AFNI
* C3D
* Freesurfer's mri_convert and mris_convert
* ANTS
* dcm2niix
* heudiconv
* bids-validator
* NiftyReg
* gradunwarp
* dcmstack

Commits and pull-requests to this repository rebuild the `latest` version on Docker Hub, which is updated nightly to Singularity Hub. Releases on Docker Hub and Singularity Hub are built whenever a tag named `v.*` is committed. To avoid re-building on minor commits (e.g. changes to documentation), use `[skip ci]` in the commit message.

[![CircleCI](https://circleci.com/gh/khanlab/neuroglia-core.svg?style=svg)](https://circleci.com/gh/khanlab/neuroglia-core)
[![https://www.singularity-hub.org/static/img/hosted-singularity--hub-%23e32929.svg](https://www.singularity-hub.org/static/img/hosted-singularity--hub-%23e32929.svg)](https://singularity-hub.org/collections/393)

Docker:
`docker pull khanlab/neuroglia-dwi`

Singularity:
`singularity pull khanlab/neuroglia-dwi`
