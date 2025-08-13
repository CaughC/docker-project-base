#!/bin/bash

if [ "$INSTALL_GPU" = "true" ]; then
  echo "Checking GPU availability with nvidia-smi..."
  if command -v nvidia-smi &> /dev/null
  then
    nvidia-smi
  else
    echo "nvidia-smi not found. GPU drivers might not be installed or configured correctly."
  fi
else
  echo "GPU installation not requested (INSTALL_GPU is not 'true'). Skipping nvidia-smi check."
fi
