FROM nvcr.io/nvidia/deepstream:6.1-samples

# Update GPG public keys (https://github.com/NVIDIA/nvidia-docker/issues/1631)
RUN apt-key del 7fa2af80 && \
    apt install wget && \
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-keyring_1.0-1_all.deb && \
    dpkg -i cuda-keyring_1.0-1_all.deb && \
    rm cuda-keyring_1.0-1_all.deb && \
    apt-get clean && apt-get autoremove -y 
    
# Install needed libraries
RUN apt-get update -y && apt-get install --no-install-recommends -y \
    # Dependencies for LightTrack
    libeigen3-dev \
    cmake && \
    apt-get clean && apt-get autoremove -y 

WORKDIR /opt/nvidia/deepstream/deepstream-6.1/samples/configs/deepstream-app/
RUN mkdir /opt/nvidia/deepstream/deepstream-6.1/samples/configs/deepstream-app/MyCustomThings
COPY MyCustomThings /opt/nvidia/deepstream/deepstream-6.1/samples/configs/deepstream-app/MyCustomThings

RUN cp /opt/nvidia/deepstream/deepstream-6.1/samples/configs/deepstream-app/MyCustomThings/config_infer_custom_vision.txt /opt/nvidia/deepstream/deepstream-6.1/samples/configs/deepstream-app/ && \
    cp /opt/nvidia/deepstream/deepstream-6.1/samples/configs/deepstream-app/MyCustomThings/source4_1080p_dec_infer-resnet_tracker_sgie_tiled_display_int8.txt /opt/nvidia/deepstream/deepstream-6.1/samples/configs/deepstream-app/

CMD [ "deepstream-app", "-c", "source4_1080p_dec_infer-resnet_tracker_sgie_tiled_display_int8.txt"]