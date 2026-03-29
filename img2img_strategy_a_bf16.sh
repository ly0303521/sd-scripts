#!/bin/bash
# 创建推理结果目录
mkdir -p img2img_results

# 输入图片路径
INPUT_IMAGE="/workspace/sd-scripts/test_images/DSC_7476-1.webp"

if [ ! -f "$INPUT_IMAGE" ]; then
    echo "Error: Test image not found at $INPUT_IMAGE"
    exit 1
fi

echo "Using input image: $INPUT_IMAGE"

# 设置推理参数
MODEL_PATH="output/my_sdxl_lora.safetensors"
# PROMPT="oilpstyle --n nsfw, low quality, bad anatomy, text, watermark"
PROMPT="oilpstyle"
STRENGTH=0.5

python sdxl_gen_img.py \
  --ckpt stabilityai/stable-diffusion-xl-base-1.0 \
  --network_module networks.lora \
  --network_weights "$MODEL_PATH" \
  --network_mul 1.0 \
  --image_path "$INPUT_IMAGE" \
  --strength "$STRENGTH" \
  --prompt "$PROMPT" \
  --outdir "img2img_results" \
  --steps 30 \
  --sampler euler_a \
  --seed 123 \
  --W 1024 \
  --H 1024 \
  --bf16 \
  --sdpa

echo "Img2Img with --bf16 completed. This should resolve both black images and dtype mismatch."
