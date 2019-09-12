FROM ubuntu:18.04
RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y ninja-build build-essential git-core autotools-dev cmake pkg-config
RUN apt-get install -y debhelper cdbs dpkg-dev
RUN apt-get install -y xmlto libssl1.0-dev libxi-dev libxrender-dev libxext-dev libxinerama-dev libxfixes-dev libxcursor-dev libxv-dev libxdamage-dev libxtst-dev libcups2-dev libpcsclite-dev libasound2-dev libpulse-dev libjpeg-dev libgsm1-dev libusb-1.0-0-dev libudev-dev libdbus-glib-1-dev uuid-dev libxml2-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libavutil-dev libavcodec-dev libavresample-dev
RUN apt-get install -y libxkbfile-dev libxrandr-dev libcairo2-dev
RUN mkdir ./package/ && cd ./package/ && git clone https://github.com/msabansal/FreeRDP -b stable-1.1-extra
RUN cd ./package/FreeRDP && dpkg-buildpackage -b -rfakeroot -us -uc
RUN mkdir ./package/debs/
RUN mv ./package/*.deb ./package/debs/
RUN dpkg-scanpackages ./package/debs/ | gzip > ./package/debs/Packages.gz
