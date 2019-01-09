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
RUN bash /src/install_scripts/29.install_connectomeworkbench_by_binary.sh > log_29_workbench

#SPM (from neurodocker):
ENV FORCE_SPMMCR="1" \
    LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu:/opt/matlabmcr-2010a/v713/runtime/glnxa64:/opt/matlabmcr-2010a/v713/bin/glnxa64:/opt/matlabmcr-2010a/v713/sys/os/glnxa64:/opt/matlabmcr-2010a/v713/extern/bin/glnxa64" \
    MATLABCMD="/opt/matlabmcr-2010a/v713/toolbox/matlab"
RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends \
           bc \
           libncurses5 \
           libxext6 \
           libxmu6 \
           libxpm-dev \
           libxt6 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && echo "Downloading MATLAB Compiler Runtime ..." \
    && curl -sSL --retry 5 -o /tmp/toinstall.deb http://mirrors.kernel.org/debian/pool/main/libx/libxp/libxp6_1.0.2-2_amd64.deb \
    && dpkg -i /tmp/toinstall.deb \
    && rm /tmp/toinstall.deb \
    && apt-get install -f \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && curl -fsSL --retry 5 -o /tmp/MCRInstaller.bin https://dl.dropbox.com/s/zz6me0c3v4yq5fd/MCR_R2010a_glnxa64_installer.bin \
    && chmod +x /tmp/MCRInstaller.bin \
    && /tmp/MCRInstaller.bin -silent -P installLocation="/opt/matlabmcr-2010a" \
    && rm -rf /tmp/* \
    && echo "Downloading standalone SPM ..." \
    && curl -fsSL --retry 5 -o /tmp/spm12.zip http://www.fil.ion.ucl.ac.uk/spm/download/restricted/utopia/previous/spm12_r7219_R2010a.zip \
    && unzip -q /tmp/spm12.zip -d /tmp \
    && mkdir -p /opt/spm12-r7219 \
    && mv /tmp/spm12/* /opt/spm12-r7219/ \
    && chmod -R 777 /opt/spm12-r7219 \
    && rm -rf /tmp/* \
    && /opt/spm12-r7219/run_spm12.sh /opt/matlabmcr-2010a/v713 quit \
    && sed -i '$iexport SPMMCRCMD=\"/opt/spm12-r7219/run_spm12.sh /opt/matlabmcr-2010a/v713 script\"' $ND_ENTRYPOINT


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

