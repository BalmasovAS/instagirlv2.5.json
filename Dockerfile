# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
RUN comfy node install --exit-on-fail comfy-image-saver --mode remote
RUN comfy node install --exit-on-fail ComfyUI-GGUF@1.1.10
RUN comfy node install --exit-on-fail comfyui-kjnodes@1.2.9

# download models into comfyui
RUN comfy model download --url https://huggingface.co/QuantStack/Wan2.2-T2V-A14B-GGUF/blob/main/LowNoise/Wan2.2-T2V-A14B-LowNoise-Q8_0.gguf --relative-path models/diffusion_models --filename Wan2.2-T2V-A14B-LowNoise-Q8_0.gguf
RUN comfy model download --url https://huggingface.co/QuantStack/Wan2.2-T2V-A14B-GGUF/blob/main/HighNoise/Wan2.2-T2V-A14B-HighNoise-Q8_0.gguf --relative-path models/diffusion_models --filename Wan2.2-T2V-A14B-HighNoise-Q8_0.gguf
RUN comfy model download --url https://huggingface.co/Kijai/WanVideo_comfy/blob/main/Wan21_T2V_14B_lightx2v_cfg_step_distill_lora_rank32.safetensors --relative-path models/loras --filename Wan21_T2V_14B_lightx2v_cfg_step_distill_lora_rank32.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors --relative-path models/text_encoders --filename umt5_xxl_fp8_e4m3fn_scaled.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors --relative-path models/vae --filename wan_2.1_vae.safetensors
RUN comfy model download --url https://huggingface.co/allyourtech/instagirl/blob/main/Instagirlv2.5-HIGH.safetensors --relative-path models/loras --filename Instagirlv2.5-HIGH.safetensors
RUN comfy model download --url https://huggingface.co/wavespeed/Instagirlv2.5/blob/main/Instagirlv2.5-LOW.safetensors --relative-path models/loras --filename Instagirlv2.5-LOW.safetensors
RUN comfy model download --url https://huggingface.co/dci05049/Wan2.2-serverless/blob/2f8a378abd3fdff0b00274387555f19a3f12b546/l3n0v0.safetensors --relative-path models/loras --filename l3n0v0.safetensors
# RUN # Could not find URL for 277391af-67b3-4f6f-9622-be5408457c57_346d3e44-599d-4a88-b5ad-3ba72b4ed90c.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
