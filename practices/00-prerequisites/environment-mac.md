# Cài đặt Môi trường - macOS

## Thời lượng: 1.5 giờ

## 1. Cài đặt Homebrew

Homebrew là package manager chuẩn cho macOS.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Sau khi cài, thêm vào PATH (cho Apple Silicon):
```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Verify:
```bash
brew --version
```

---

## 2. Cài đặt Docker Desktop

### Bước 1: Download
- Truy cập: https://www.docker.com/products/docker-desktop/
- Chọn phiên bản cho chip (Intel hoặc Apple Silicon)

### Bước 2: Cài đặt
- Mở file .dmg
- Kéo Docker vào Applications

### Bước 3: Khởi động
- Mở Docker từ Applications
- Chờ Docker khởi động hoàn tất

### Bước 4: Verify
```bash
docker --version
docker run hello-world
```

### Bước 5: Cấu hình Resources
- Docker > Settings > Resources
- Allocate: 4GB RAM, 2 CPUs (tùy máy)

---

## 3. Cài đặt Git

macOS đã có Git sẵn, nhưng nên cài phiên bản mới:

```bash
brew install git
```

### Cấu hình
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global init.defaultBranch main
```

### SSH Key
```bash
ssh-keygen -t ed25519 -C "your.email@example.com"
cat ~/.ssh/id_ed25519.pub
# Copy và thêm vào GitHub/GitLab
```

---

## 4. Cài đặt VS Code

### Bước 1: Download
```bash
brew install --cask visual-studio-code
```

Hoặc download từ: https://code.visualstudio.com/

### Bước 2: Extensions cần cài
Mở VS Code, vào Extensions (Cmd+Shift+X) và cài:
- **Docker** (Microsoft)
- **Kubernetes** (Microsoft)
- **PlantUML** (jebbs)
- **Mermaid Preview** (Yog)
- **YAML** (Red Hat)
- **REST Client** (Huachao Mao)
- **GitLens** (GitKraken)
- **Terraform** (HashiCorp)

### Bước 3: Command line tool
Mở VS Code, Cmd+Shift+P, gõ "Shell Command: Install 'code' command in PATH"

---

## 5. Cài đặt Node.js

### Sử dụng nvm (recommended)
```bash
brew install nvm
mkdir ~/.nvm
```

Thêm vào `~/.zshrc`:
```bash
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
```

Cài đặt Node:
```bash
source ~/.zshrc
nvm install 20
nvm use 20
nvm alias default 20
```

### Verify
```bash
node --version
npm --version
```

### Global packages
```bash
npm install -g yarn pnpm
```

---

## 6. Cài đặt Java (JDK 17+)

### Sử dụng Homebrew
```bash
brew install openjdk@17
```

### Cấu hình JAVA_HOME
Thêm vào `~/.zshrc`:
```bash
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export PATH="$JAVA_HOME/bin:$PATH"
```

### Verify
```bash
source ~/.zshrc
java --version
javac --version
```

---

## 7. Cài đặt kubectl

```bash
brew install kubectl
```

### Verify
```bash
kubectl version --client
```

---

## 8. Cài đặt Minikube

```bash
brew install minikube
```

### Start cluster
```bash
minikube start --driver=docker
```

### Verify
```bash
minikube status
kubectl get nodes
```

---

## 9. Cài đặt PlantUML

### Cài đặt Graphviz (dependency)
```bash
brew install graphviz
```

### PlantUML
```bash
brew install plantuml
```

VS Code extension PlantUML sẽ tự động sử dụng.

---

## 10. Cài đặt Terraform

```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

### Verify
```bash
terraform --version
```

---

## 11. Cài đặt AWS CLI

```bash
brew install awscli
```

### Cấu hình
```bash
aws configure
# Nhập Access Key ID, Secret Access Key, Region (ap-southeast-1), Output format (json)
```

---

## 12. Cài đặt Azure CLI (Optional)

```bash
brew install azure-cli
```

### Login
```bash
az login
```

---

## 13. Công cụ bổ sung (Recommended)

```bash
# Terminal tools
brew install jq # JSON processor
brew install yq # YAML processor
brew install httpie # Better curl
brew install watch # Watch command output
brew install tree # Directory tree

# Kubernetes tools
brew install helm # Kubernetes package manager
brew install k9s # Kubernetes TUI
brew install kubectx # Switch kubectl context

# Development
brew install redis # For local testing
brew install postgresql # For local testing
```

---

## Checklist Xác nhận

```bash
# Check tất cả
echo "=== Environment Check ==="
docker --version
git --version
node --version
java --version
kubectl version --client
minikube version
terraform --version
aws --version
plantuml -version
```

**Output mong đợi:**
```
=== Environment Check ===
Docker version 24.x.x
git version 2.4x.x
v20.x.x
openjdk 17.x.x
Client Version: v1.29.x
minikube version: v1.32.x
Terraform v1.6.x
aws-cli/2.x.x
PlantUML version 1.x.x
```

---

## Troubleshooting

### Docker không start
1. Kiểm tra Docker Desktop đang chạy (icon trên menu bar)
2. Restart Docker Desktop
3. Reset to factory defaults (nếu cần)

### Minikube không start
```bash
minikube delete
minikube start --driver=docker
```

### Permission denied khi chạy scripts
```bash
chmod +x script.sh
```

### Homebrew packages không tìm thấy
```bash
brew update
brew upgrade
```

---

## Tiếp theo

Sau khi hoàn thành, tiếp tục với:
- `cloud-accounts.md` - Đăng ký tài khoản cloud
- `tools-setup.md` - Cài đặt thêm công cụ
