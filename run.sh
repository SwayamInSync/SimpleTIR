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
export HYDRA_OVERRIDES="actor_rollout_ref.rollout.n=6"

bash train.sh \
  --max_response_length 4000 \
  --max_prompt_length 8000 \
  --model_name Qwen2.5-7B \
  --max_turns 3 \
  --train_batch_size 512 \
  --val_sample_size 50 \
  --n_val 4 \
  --val_before_train True \
  --test_freq 20 \
  --mask_void_turns False \
  --train_dataset "simplelr_math_35/train"
  # Use only simplelr_math_35 (8.5k samples) for faster experiments
  # Full dataset: "simplelr_math_35/train deepscaler/train" (48k samples)
  # --mask_tool_output False \