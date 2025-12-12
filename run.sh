export MODEL_PATH="Qwen"
export DATA_PATH="/workspace/SimpleTIR/datasets/"
export CHECKPOINT_PATH=checkpoints
export LOG_PATH=logs
export NNODES=1
export GPUS_PER_NODE=8
export RESUME=False
export CONFIG_NAME=simpletir_trainer

export SANDBOX_ENDPOINT=http://127.0.0.1:12345/faas/sandbox/

# Add custom hydra overrides for faster training
export HYDRA_OVERRIDES="actor_rollout_ref.rollout.n=8"

bash train.sh \
  --max_response_length 8000 \
  --max_prompt_length 16000 \
  --model_name Qwen2.5-7B \
  --max_turns 3 \
  --train_batch_size 512 \
  --val_sample_size 50 \
  --n_val 8 \
  --mask_void_turns False \
  --train_dataset "simplelr_math_35/train deepscaler/train"
  # --mask_tool_output False \