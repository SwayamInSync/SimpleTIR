sudo apt-get update && sudo apt-get install -y firejail
uv pip install "fastapi[all]" uvicorn aiohttp

sudo tee /etc/firejail/sandbox.profile << 'EOF'
# /etc/firejail/sandbox.profile
# Minimal sandbox for Python code execution

# Disable networking
net none

# Private filesystem rooted at --private dir
private

# Resource limits (use lowercase suffix)
rlimit-as 512m
rlimit-cpu 3
rlimit-nproc 50

# Security hardening
caps.drop all
seccomp
noroot

# Allow python3
noblacklist /usr/bin/python3
EOF

export SANDBOX_ENDPOINT=http://127.0.0.1:12345/faas/sandbox/

# running sandbox
uvicorn sandbox_api:app --host 127.0.0.1 --port 12345 --workers 4

# testing sandbox
# SANDBOX_ENDPOINT=http://127.0.0.1:12345/faas/sandbox/ python local_sandbox.py