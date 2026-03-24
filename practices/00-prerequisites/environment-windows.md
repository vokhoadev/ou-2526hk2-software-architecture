# Cài đặt Môi trường - Windows

## Thời lượng: 2 giờ

## 1. Cài đặt WSL2 (Windows Subsystem for Linux)

### Bước 1: Kích hoạt WSL
Mở PowerShell với quyền Administrator và chạy:

```powershell
wsl --install
```

### Bước 2: Restart máy tính

### Bước 3: Cài đặt Ubuntu
```powershell
wsl --install -d Ubuntu-22.04
```

### Bước 4: Cấu hình Ubuntu
- Tạo username và password
- Update packages:
```bash
sudo apt update && sudo apt upgrade -y
```

---

## 2. Cài đặt Docker Desktop

### Bước 1: Download
- Truy cập: https://www.docker.com/products/docker-desktop/
- Download Docker Desktop for Windows

### Bước 2: Cài đặt
- Chạy installer
- Chọn "Use WSL 2 instead of Hyper-V"
- Restart máy nếu được yêu cầu

### Bước 3: Verify
```powershell
docker --version
docker run hello-world
```

### Bước 4: Cấu hình Resources
- Settings > Resources > WSL Integration
- Enable integration với Ubuntu-22.04
- Allocate: 4GB RAM, 2 CPUs (tùy máy)

---

## 3. Cài đặt Git

### Bước 1: Download
- https://git-scm.com/download/win

### Bước 2: Cấu hình
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global init.defaultBranch main
```

### Bước 3: SSH Key (optional nhưng recommended)
```bash
ssh-keygen -t ed25519 -C "your.email@example.com"
```

---

## 4. Cài đặt VS Code

### Bước 1: Download
- https://code.visualstudio.com/

### Bước 2: Extensions cần cài
- **Remote - WSL** (Microsoft)
- **Docker** (Microsoft)
- **Kubernetes** (Microsoft)
- **PlantUML** (jebbs)
- **Mermaid Preview** (Yog)
- **YAML** (Red Hat)
- **REST Client** (Huachao Mao)
- **GitLens** (GitKraken)

### Bước 3: Settings
Mở Settings (Ctrl+,) và cấu hình:
```json
{
 "terminal.integrated.defaultProfile.windows": "Git Bash",
 "files.eol": "\n",
 "editor.formatOnSave": true
}
```

---

## 5. Cài đặt Node.js

### Bước 1: Download
- https://nodejs.org/ (LTS version - 20.x hoặc mới hơn)

### Bước 2: Verify
```powershell
node --version
npm --version
```

### Bước 3: Cài đặt global packages
```bash
npm install -g yarn pnpm
```

---

## 6. Cài đặt Java (JDK 17+)

### Bước 1: Download
- https://adoptium.net/ (Eclipse Temurin)
- Chọn JDK 17 hoặc 21 LTS

### Bước 2: Cấu hình JAVA_HOME
- System Properties > Environment Variables
- New System Variable:
 - Name: `JAVA_HOME`
 - Value: `C:\Program Files\Eclipse Adoptium\jdk-17.x.x`
- Thêm vào PATH: `%JAVA_HOME%\bin`

### Bước 3: Verify
```powershell
java --version
javac --version
```

---

## 7. Cài đặt kubectl (Kubernetes CLI)

### Bước 1: Download
```powershell
curl.exe -LO "https://dl.k8s.io/release/v1.29.0/bin/windows/amd64/kubectl.exe"
```

### Bước 2: Thêm vào PATH
- Di chuyển kubectl.exe đến thư mục trong PATH (ví dụ: `C:\tools\`)
- Thêm thư mục vào System PATH

### Bước 3: Verify
```powershell
kubectl version --client
```

---

## 8. Cài đặt Minikube (Local Kubernetes)

### Bước 1: Download
```powershell
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-installer.exe
```

### Bước 2: Chạy installer

### Bước 3: Start cluster
```powershell
minikube start --driver=docker
```

---

## 9. Cài đặt PlantUML

### Bước 1: Cài đặt Graphviz
- Download từ https://graphviz.org/download/
- Thêm vào PATH: `C:\Program Files\Graphviz\bin`

### Bước 2: Cài đặt PlantUML
```bash
# Trong VS Code, extension PlantUML đã đủ
# Hoặc download plantuml.jar từ https://plantuml.com/download
```

---

## 10. Cài đặt Terraform

### Bước 1: Download
- https://developer.hashicorp.com/terraform/downloads

### Bước 2: Giải nén và thêm vào PATH

### Bước 3: Verify
```powershell
terraform --version
```

---

## Checklist Xác nhận

Chạy các lệnh sau để xác nhận cài đặt thành công:

```powershell
# Check tất cả
docker --version
git --version
node --version
java --version
kubectl version --client
minikube version
terraform --version
```

**Output mong đợi:**
```
Docker version 24.x.x
git version 2.4x.x
v20.x.x
openjdk 17.x.x
Client Version: v1.29.x
minikube version: v1.32.x
Terraform v1.6.x
```

---

## Troubleshooting

### Docker không start được
1. Kiểm tra Virtualization đã enable trong BIOS
2. Kiểm tra Hyper-V đã disable
3. Restart WSL: `wsl --shutdown`

### WSL quá chậm
1. Tạo file `.wslconfig` tại `C:\Users\<username>`:
```ini
[wsl2]
memory=4GB
processors=2
```

### kubectl không kết nối được Minikube
```powershell
minikube kubectl -- get pods
```

---

## Tiếp theo

Sau khi hoàn thành, tiếp tục với:
- `cloud-accounts.md` - Đăng ký tài khoản cloud
- `tools-setup.md` - Cài đặt thêm công cụ
