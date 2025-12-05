#!/bin/bash

echo "detecting GPU and installing appropriate drivers"
GPU_INFO=$(lspci | grep -E "VGA|3D|Display")
if [ -z "$GPU_INFO" ]; then
    echo "no GPU detected, exiting"
    exit 1
else
    echo "detected GPU: Installing drivers for all detected GPUs"
    paru -Sy --needed --noconfirm cuda-toolkit egl-wayland mesa mesa-utils lib32-mesa vulkan-tools
fi
if echo "$GPU_INFO" | grep -qi "NVIDIA"; then
    # Verify the GPU family to decide on the driver installation
    if echo "$GPU_INFO" | grep -qi "NVIDIA Corporation TU"; then
        echo "installing nvidia drivers for Turing architecture (nvidia-open)"
        paru -Sy --needed --noconfirm nvidia-open
    elif echo "$GPU_INFO" | grep -qi "NVIDIA Corporation GM|NVIDIA Corporation AD"; then
        echo "installing nvidia drivers for Maxwell or Ada Lovelace architecture"
        paru -Sy --needed --noconfirm nvidia
    else
        echo "GPU faamily not found, installing newest nvidia drivers (nvidia-open)"
        paru -Sy --needed --noconfirm nvidia-open
    fi 
    echo "installing auxiliar nvidia pkgs"
    paru -Sy --needed --noconfirm nvidia-prime nvidia-utils libva-nvidia-driver
    # sudo modprobe nvidia
if echo "$GPU_INFO" | grep -qi "Intel"; then
    echo "installing intel drivers"
    paru -Sy --needed --noconfirm intel-media-driver vulkan-intel lib32-vulkan-intel libva-intel-driver libva-utils
fi
fi
if echo "$GPU_INFO" | grep -qi "AMD"; then
    GPU_TYPE="amd"
    echo "installing amd drivers"
    paru -Sy --needed --noconfirm xf86-video-amdgpu libva-mesa-driver lib32-libva-mesa-driver
fi
