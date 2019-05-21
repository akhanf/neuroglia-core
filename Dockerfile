FROM neurodebian:stretch-non-free
MAINTAINER <alik@robarts.ca>

RUN mkdir -p /src/install_scripts
COPY install_scripts/ /src/install_scripts

ENV DEBIAN_FRONTEND noninteractive
RUN bash /src/install_scripts/00.install_basics_sudo.sh > log_00_basics
RUN bash /src/install_scripts/03.install_anaconda2_nipype_dcmstack_by_binary.sh /opt > log_03_python
RUN bash /src/install_scripts/04.install_octave_sudo.sh  > log_04_octave
RUN bash /src/install_scripts/10.install_afni_fsl_sudo.sh > log_10_afni
RUN python /src/install_scripts/fslinstaller.py -d /opt/fsl > log_11_fsl
RUN bash /src/install_scripts/12.install_c3d_by_binary.sh /opt > log_12_c3d
RUN bash /src/install_scripts/15.install_freesurfer_minimal_by_binary.sh /opt > log_15_freesurferminimal
RUN bash /src/install_scripts/16.install_ants_by_binary.sh /opt > log_16_ants
RUN bash /src/install_scripts/17.install_dcm2niix_by_binary.sh /opt > log_17_dcm2niix
RUN bash /src/install_scripts/23.install_heudiconv_by_source.sh /opt > log_23_heudiconv
RUN bash /src/install_scripts/24.install_bids-validator_sudo.sh > log_24_bids-validator
RUN bash /src/install_scripts/25.install_niftyreg_by_source.sh /opt > log_25_niftyreg
RUN bash /src/install_scripts/28.install_gradunwarp_by_source.sh /opt > log_28_gradunwarp
RUN bash /src/install_scripts/29.install_connectomeworkbench_by_binary.sh /opt > log_29_workbench
RUN bash /src/install_scripts/30.install_datalad-osf_by_source_sudo.sh /opt > log_30_dataladosf


#remove all install scripts
RUN rm -rf /src


#anaconda2
ENV PATH /opt/anaconda2/bin/:$PATH

#c3d
ENV PATH /opt/c3d/bin:$PATH

#fsl
ENV FSLDIR /opt/fsl
ENV POSSUMDIR $FSLDIR
ENV PATH $FSLDIR/bin:$PATH
ENV FSLOUTPUTTYPE NIFTI_GZ
ENV FSLMULTIFILEQUIT TRUE
ENV FSLTCLSH /usr/bin/tclsh
ENV FSLWISH /usr/bin/wish
ENV FSLBROWSER /etc/alternatives/x-www-browser
ENV LD_LIBRARY_PATH $FSLDIR/lib:${LD_LIBRARY_PATH}


#ants
ENV PATH /opt/ants:$PATH
ENV ANTSPATH /opt/ants

#dcm2niix
ENV PATH /opt/mricrogl_lx:$PATH

#heudiconv
ENV PYTHONPATH /opt/heudiconv:$PYTHONPATH

#niftyreg
ENV LD_LIBRARY_PATH /opt/niftyreg-1.3.9/lib:$LD_LIBRARY_PATH 
ENV PATH /opt/niftyreg-1.3.9/bin:$PATH

#matlab on graham (requires user to be on sharcnet matlab users list)
ENV JAVA_HOME /cvmfs/soft.computecanada.ca/easybuild/software/2017/Core/java/1.8.0_121
ENV MLM_LICENSE_FILE /cvmfs/restricted.computecanada.ca/config/licenses/matlab/inst_uwo/graham.lic
ENV PATH /cvmfs/restricted.computecanada.ca/easybuild/software/2017/Core/matlab/2017a:/cvmfs/restricted.computecanada.ca/easybuild/software/2017/Core/matlab/2017a/bin:/cvmfs/soft.computecanada.ca/easybuild/software/2017/Core/java/1.8.0_121:/cvmfs/soft.computecanada.ca/easybuild/software/2017/Core/java/1.8.0_121/bin:$PATH
ENV _JAVA_OPTIONS -Xmx256m
ENV LIBRARY_PATH /cvmfs/soft.computecanada.ca/easybuild/software/2017/Core/java/1.8.0_121/lib

#freesurfer - minimal
ENV FREESURFER_HOME /opt/freesurfer_minimal
ENV PATH $FREESURFER_HOME/bin:$PATH

#connectome workbench 
ENV PATH /opt/workbench/bin_linux64:$PATH

